import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_document_request.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/waiting_page.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/bloc.dart';
import 'widgets.dart';

class DocumentControlsWidget extends StatefulWidget {
  List<List<String>> documentTypes = [];
  List<DriverDocuments> documents = [];
  final bool isBtnEnabled;
  final bool isSplash;
  final int countRequired;
  final int countUploaded;
  final Configuration configuration;

  DocumentControlsWidget({
    Key? key,
    required this.documentTypes,
    required this.documents,
    required this.isBtnEnabled,
    required this.isSplash,
    required this.countRequired,
    required this.countUploaded,
    required this.configuration,
  }) : super(key: key);

  @override
  _DocumentControlsWidgetState createState() => _DocumentControlsWidgetState(
        documentTypes: documentTypes,
        documents: documents,
        isBtnEnabled: isBtnEnabled,
        isSplash: isSplash,
        countRequired: countRequired,
        countUploaded: countUploaded,
        configuration: configuration,
      );
}

class _DocumentControlsWidgetState extends State<DocumentControlsWidget> {
  List<List<String>> documentTypes = [];
  List<DriverDocuments> documents = [];
  final bool isBtnEnabled;
  final bool isSplash;
  final Configuration configuration;
  bool isPic = false;
  XFile? picFile;
  File? pdfFile;
  final ImagePicker picker = ImagePicker();
  String? retrieveDataError;

  final int countRequired;
  final int countUploaded;
  var colorsBtnBack = Colors.grey.shade300;
  Color colorsBtnTxt = Colors.grey;

  _DocumentControlsWidgetState({
    required this.documentTypes,
    required this.documents,
    required this.isBtnEnabled,
    required this.isSplash,
    required this.countRequired,
    required this.countUploaded,
    required this.configuration,
  }) {
    if (isBtnEnabled) {
      colorsBtnBack = Colors.green;
      colorsBtnTxt = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$countUploaded out of $countRequired uploaded',
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
        const SizedBox(height: 16),
        Container(
          height: (isSplash || countUploaded != countRequired) ? 400 : 550,
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: documentRows(context)),
        ),
        const SizedBox(height: 40),
        Visibility(
          visible: isSplash,
          child: MaterialButton(
            onPressed: isBtnEnabled ? onBtnClicked : null,
            child: Container(
              height: 50,
              color: colorsBtnBack,
              child: Row(
                children: [
                  Text(
                    AppConstants.strFinish,
                    style: TextStyle(fontSize: 20, color: colorsBtnTxt),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: colorsBtnTxt,
                  ),
                ],
              ),
            ),
            color: Colors.green,
            disabledColor: Colors.grey.shade300,
            textColor: Colors.white,
            disabledTextColor: Colors.grey,
            minWidth: MediaQuery.of(context).size.width - 100,
            height: 44,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> documentRows(BuildContext context) {
    var documentRows = <Widget>[];

    for (List<String> documentType in documentTypes) {
      String typeDocument = documentType.elementAt(0);
      bool isUpload = true;
      bool isDone = false;
      for (DriverDocuments document in documents) {
        if (document.documentType.toString().replaceAll(' ', '') ==
            typeDocument) {
          isDone = true;
          isUpload = false;
          break;
        }
      }

      Widget documentRow = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Text(
              getCleanedStringFirst(documentType.elementAt(1)),
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Spacer(),
            Visibility(
              visible: isDone,
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              ),
            ),
            Visibility(
              visible: isUpload,
              child: TextButton(
                child: const Text(AppConstants.strUpload,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )),
                onPressed: () {
                  onBtnClickedUpload(typeDocument);
                },
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Visibility(
            visible: documentType.elementAt(2).replaceAll(' ', '') == 'true',
            child: Text(
              AppConstants.strDocReq,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ),
          SizedBox(height: 32),
        ],
      );

      documentRows.add(documentRow);
    }

    return documentRows;
  }

  String getCleanedStringFirst(String value) {
    String result = value;
    int startPos = 0;
    for (int i = 0; i < value.length; i++) {
      if (value.characters.elementAt(i).isEmpty ||
          value.characters.elementAt(i) == ' ' && startPos < value.length) {
        startPos++;
      } else {
        break;
      }
    }
    result = value.substring(startPos);
    return result;
  }

  Future<void> showDialogImagePicker(
      BuildContext context, String documentType) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 108,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                Center(
                  child:
                      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(documentType),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return const Text(
                                      'You have not yet picked an image.',
                                      textAlign: TextAlign.center,
                                    );
                                  case ConnectionState.done:
                                    return getPicSelection();
                                  default:
                                    if (snapshot.hasError) {
                                      return DialogWidget(
                                        message: snapshot.error.toString(),
                                        isDismiss: true,
                                        typeDialog: AppConstants.dialogTypeErr,
                                      );
                                    } else {
                                      return DialogWidget(
                                        message: AppConstants.errMsgPic,
                                        isDismiss: true,
                                        typeDialog: AppConstants.dialogTypeErr,
                                      );
                                    }
                                }
                              },
                            )
                          : Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 50,
                                maxWidth: 300,
                                maxHeight: 300);
                            setPickedImage(image, documentType);
                          },
                          icon: const Icon(
                            Icons.photo_library,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 50,
                                maxWidth: 300,
                                maxHeight: 300);
                            setPickedImage(image, documentType);
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            setPickedFile(result, documentType);
                          },
                          icon: const Icon(
                            Icons.folder,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> retrieveLostData(String documentType) async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        setPickedImage(response.file, documentType);
      });
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  Widget getPicSelection() {
    if (retrieveDataError != null) {
      String errMsg = retrieveDataError!;
      retrieveDataError = null;
      return DialogWidget(
        message: errMsg,
        isDismiss: true,
        typeDialog: AppConstants.dialogTypeErr,
      );
    } else {
      return Container();
    }
  }

  void setPickedImage(XFile? image, String documentType) {
    if (image != null) {
      picFile = image;
      isPic = true;
      addDocuments(documentType);
    }
  }

  void setPickedFile(FilePickerResult? result, String documentType) {
    String? filePath = result?.files.single.path;
    if (filePath != null) {
      pdfFile = File(filePath);
      isPic = false;
      addDocuments(documentType);
    }
  }

  void onBtnClickedUpload(String documentType) {
    showDialogImagePicker(context, documentType);
  }

  void onBtnClicked() {
    if (isBtnEnabled) {
      onNext();
    }
  }

  void onNext() {
    if (isSplash) {
      Get.offAll(() => WaitingPage(configuration: configuration,));
    } else {
      Get.back();
    }
  }

  void addDocuments(String documentType) {
    BlocProvider.of<DocumentBloc>(context).add(GetDocument(
        DriverDocumentRequest(
            isPic: isPic,
            docType: documentType,
            pdfDoc: pdfFile,
            picDoc: picFile)));
  }
}
