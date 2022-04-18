import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';

class DriverDocumentsModel extends DriverDocuments {
  const DriverDocumentsModel({required int id, required int documentType})
      : super(id: id, documentType: documentType);

  factory DriverDocumentsModel.fromJson(json) {
    return DriverDocumentsModel(
        id: json['id'], documentType: json['document_type']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "document_type": documentType,
    };
  }
}
