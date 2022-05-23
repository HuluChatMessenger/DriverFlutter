import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/bloc.dart';
import 'widgets.dart';

class PicControlsWidget extends StatefulWidget {
  XFile? selectedPic;

  PicControlsWidget({
    Key? key,
    this.selectedPic,
  }) : super(key: key);

  @override
  _PicControlsWidgetState createState() =>
      _PicControlsWidgetState(selectedPic: selectedPic);
}

class _PicControlsWidgetState extends State<PicControlsWidget> {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  XFile? selectedPic;
  String? retrieveDataError;
  var pickedImage = CircleAvatar(
    radius: 104, // Image radius
    child: Image.asset('assets/images/place_holder_profile.png'),
  );
  String? pic;

  _PicControlsWidgetState({this.selectedPic}) {
    if (selectedPic != null) {
      imageFile = selectedPic;
      pic = selectedPic?.path;
      pickedImage = CircleAvatar(
        radius: 104,
        backgroundImage: FileImage(File(pic!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () async {
            await showDialogImagePicker(context);
          },
          child: pickedImage,
        ),
        Positioned(
          bottom: 4,
          right: 8,
          child: Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                await showDialogImagePicker(context);
              },
              icon: const Icon(
                Icons.add,
                size: 38,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showDialogImagePicker(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 108,
            child: Column(
              children: [
                const SizedBox(
                  height: 44,
                ),
                Center(
                  child:
                      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(),
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
                                        message: 'errMsgPic'.tr,
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
                      decoration: const BoxDecoration(
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
                            if (image != null) setPickedImage(image);
                          },
                          icon: const Icon(
                            Icons.photo_library,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
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
                            if (image != null) setPickedImage(image);
                          },
                          icon: const Icon(
                            Icons.camera_alt,
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

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        imageFile = response.file;
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

  void setPickedImage(XFile image) {
    imageFile = image;
    pic = image.path;
    if (pic != null) {
      addPic(image);
      setState(() {
        pickedImage = CircleAvatar(
          radius: 104,
          backgroundImage: FileImage(File(pic!)),
        );
      });
    }
  }

  void addPic(XFile input) {
    BlocProvider.of<PicBloc>(context).add(GetPic(input));
  }
}
