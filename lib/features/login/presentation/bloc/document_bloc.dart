import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/get_configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/usecases/post_document.dart';

import 'bloc.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final PostDocument postDocument;
  final GetConfiguration getConfiguration;

  DocumentBloc({required this.postDocument, required this.getConfiguration})
      : super(DocumentInitial()) {
    on<DocumentEvent>(mapDocumentState);
  }

  Future<void> mapDocumentState(
    DocumentEvent event,
    Emitter<DocumentState> emit,
  ) async {
    if (event is GetDocument) {
      print('LogHulu Document: Request started');
      emit(LoadingDocument());

      final failureOrSuccess =
          await postDocument(ParamsDoc(doc: event.documentRequest));
      await failureOrSuccess.fold(
        (failure) async {
          print('LogHulu Document: Response error');
          return emit(ErrorDocument(message: _mapFailureToMessage(failure)));
        },
        (success) async {
          print('LogHulu Document: $success  ===|||=== result.');

          final failureOrSuccessConfig = await getConfiguration(null);

          failureOrSuccessConfig.fold(
            (failureConfig) {

              print('LogHulu Document Failure Driver: $failureConfig  ===|||=== result.');

              List<DriverDocuments> documents = [];
              if (success.driverDocuments != null) {
                documents = success.driverDocuments!;
              }
              return emit(LoadedDocument(documents: documents));
            },
            (successConfig) {

              print('LogHulu Document Success Driver: $successConfig  ===|||=== result.');
              List<DriverDocuments> documents = [];
              if (success.driverDocuments != null) {
                documents = success.driverDocuments!;
              }
              return emit(LoadedDocument(
                  documents: documents, configuration: successConfig));
            },
          );
        },
      );
    }
  }

  String _mapFailureToMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        if (failure is ServerFailure &&
            failure.errMsg != null &&
            failure.errMsg!.isNotEmpty) {
          return failure.errMsg!;
        } else {
          return AppConstants.errMsgServer;
        }
      case ConnectionFailure:
        return AppConstants.errMsgConnection;
      default:
        return AppConstants.errMsgUnknown;
    }
  }
}
