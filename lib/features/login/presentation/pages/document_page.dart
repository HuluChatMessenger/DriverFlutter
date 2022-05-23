import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/common_utils.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/presentation/bloc/bloc.dart';
import 'package:hulutaxi_driver/features/login/presentation/pages/splash_page.dart';
import 'package:hulutaxi_driver/injection_container.dart';

import '../../../../core/util/constants.dart';
import '../widgets/widgets.dart';

class DocumentPage extends StatelessWidget {
  List<List<String>> documentTypes = [];
  List<DriverDocuments> documents = [];
  final bool isSplash;
  Configuration configuration;

  DocumentPage(
      {Key? key,
      required this.documentTypes,
      required this.documents,
      required this.isSplash,
      required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<DocumentBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<DocumentBloc>(),
        child: BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            if (state is LoadingDocument) {
              return buildDocumentWidget(context, null, null, true, null);
            } else if (state is LoadedDocument) {
              configuration = state.configuration != null
                  ? state.configuration!
                  : configuration;
              return buildDocumentWidget(
                  context,
                  state.configuration?.documentTypes,
                  state.documents,
                  false,
                  null);
            } else if (state is ErrorDocument) {
              return buildDocumentWidget(
                  context, null, null, false, state.message);
            } else {
              return buildDocumentWidget(context, null, null, false, null);
            }
          },
        ));
  }

  Widget buildDocumentWidget(
    BuildContext context,
    List<List<String>>? configurationCurrent,
    List<DriverDocuments>? documentsCurrent,
    bool isLoading,
    String? errMsg,
  ) {
    List<List<String>> configurationWidget =
        (configurationCurrent != null) ? configurationCurrent : documentTypes;
    List<DriverDocuments> documentsWidget =
        (documentsCurrent != null) ? documentsCurrent : documents;
    if (documentsWidget == null || documentsWidget.isEmpty) {
      documents = [];
    } else {
      documents = documentsWidget;
    }
    documentTypes = configurationWidget;

    int countRequired =
        CommonUtils().countDocsRequired(documentTypes, documents);
    int countUploaded =
        CommonUtils().countDocsUploaded(documentTypes, documents);

    print('LogHulu : $documentTypes  ===|||=== $documents  ===|||==== result.');

    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                if (isSplash) {
                  return Container();
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  );
                }
              },
            ),
            title: title(),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                backgroundTopCurveWidget(context, null),
                // Content
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: DocumentControlsWidget(
                    documentTypes: documentTypes,
                    documents: documents,
                    isBtnEnabled: countRequired == countUploaded,
                    isSplash: isSplash,
                    countRequired: countRequired,
                    countUploaded: countUploaded,
                    configuration: configuration,
                  ),
                ),
              ],
            ),
          ),
        ),
        loading(isLoading),
        error(errMsg),
      ],
    );
  }

  Widget title() {
    if (isSplash) {
      return Text('strDoc'.tr);
    } else {
      return Text('strBack'.tr);
    }
  }

  Widget loading(bool isLoading) {
    if (isLoading) {
      return const LoadingWidget();
    } else {
      return Container();
    }
  }

  Widget error(String? errMsg) {
    if (errMsg != null && errMsg.isNotEmpty) {
      return DialogWidget(
        message: errMsg,
        isDismiss: true,
        typeDialog: AppConstants.dialogTypeErr,
      );
    } else {
      return Container();
    }
  }

  void openPageWaiting() {
    Get.offAll(() => SplashPage());
  }
}
