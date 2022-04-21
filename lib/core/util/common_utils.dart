import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';

class CommonUtils {

  bool checkDocsSubmitted(List<List<String>> documentTypes,
      List<DriverDocuments>? driverDocuments) {
    bool documentSubmitted = false;
    int docsSize = documentTypes.length - 1;
    List<String> reqType = [];
    int allSubmitted = 0;
    for (int i = 0; i < docsSize; i++) {
      int posReq = documentTypes.elementAt(i).length - 1;
      if (documentTypes.elementAt(i).elementAt(posReq) == "true") {
        reqType.add(documentTypes.elementAt(i).elementAt(0));
      }
    }
    if (driverDocuments != null) {
      for (DriverDocuments document in driverDocuments) {
        for (String typeRequired in reqType) {
          if (document.documentType == typeRequired) {
            allSubmitted++;
          }
        }
      }
    }
    if (reqType.length == allSubmitted) {
      documentSubmitted = true;
    }
    return documentSubmitted;
  }
}
