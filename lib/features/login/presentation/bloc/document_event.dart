import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_document_request.dart';
import 'package:meta/meta.dart';


@immutable
abstract class DocumentEvent extends Equatable {
  const DocumentEvent([List props = const <dynamic>[]]);
}

class GetDocument extends DocumentEvent {
  final DriverDocumentRequest documentRequest;

  GetDocument(this.documentRequest) : super([documentRequest]);

  @override
  List<Object> get props => [documentRequest];
}