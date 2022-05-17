import 'package:get/get.dart';
import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/errors.dart';

class ErrorsModel extends Errors {
  const ErrorsModel({required nonFieldErrors})
      : super(nonFieldErrors: nonFieldErrors);

  factory ErrorsModel.fromJson(Map<String, dynamic> json) {
    List<String> nonFieldErrorsList = [];
    nonFieldErrorsList.add('errMsgUnknown'.tr);
    try {
      var nonFieldErrorsFromJson = json['non_field_errors'];
      nonFieldErrorsList = List<String>.from(nonFieldErrorsFromJson);
    } catch (e) {
      print('LogHulu Error: $e');
      var nonFieldErrorsFromJson = json['phonenumber'];
      nonFieldErrorsList = List<String>.from(nonFieldErrorsFromJson);
    }
    return ErrorsModel(nonFieldErrors: nonFieldErrorsList);
  }

  Map<String, dynamic> toJson() {
    return {"non_field_errors": nonFieldErrors};
  }
}
