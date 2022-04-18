import 'package:hulutaxi_driver/features/login/domain/entities/errors.dart';

class ErrorsModel extends Errors {
  const ErrorsModel({required List<String> nonFieldErrors})
      : super(nonFieldErrors: nonFieldErrors);

  factory ErrorsModel.fromJson(Map<String, dynamic> json) {
    var nonFieldErrorsFromJson = json['non_field_errors'];
    List<String> nonFieldErrorsList = List<String>.from(nonFieldErrorsFromJson);
    return ErrorsModel(nonFieldErrors: nonFieldErrorsList);
  }

  Map<String, dynamic> toJson() {
    return {"non_field_errors": nonFieldErrors};
  }
}
