import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';

class DataConverter {
  static List<List<String>> jsonToListOfListString(
      Map<String, dynamic> jsonData, String fieldName) {
    try {
      List<dynamic> dataFromJson = jsonData[fieldName];
      List<List<String>> resultList = [];

      for (dynamic result in dataFromJson) {
        List<String> results = [];
        String data =
            result.toString().substring(1, (result.toString().length - 1));
        List<dynamic> dataList = data.split(',');
        for (dynamic value in dataList) {
          String valueString = value.toString();
          results.add(valueString);
        }
        resultList.add(results);
      }

      return resultList;
    } catch (e) {
      print('Error[$fieldName]: $e');
      return [];
    }
  }
}
