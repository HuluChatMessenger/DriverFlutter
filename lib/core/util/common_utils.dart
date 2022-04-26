import 'package:flutter/material.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';

class CommonUtils {
  bool checkDocsSubmitted(List<List<String>> documentTypes,
      List<DriverDocuments>? driverDocuments) {
    bool documentSubmitted = false;
    List<String> reqType = [];
    int allSubmitted = 0;

    for (List<String> documentType in documentTypes) {
      if (documentType.elementAt(2).replaceAll(' ', '') == 'true') {
        reqType.add(documentType.first.replaceAll(' ', ''));
      }
    }

    if (driverDocuments != null) {
      for (DriverDocuments document in driverDocuments) {
        for (String typeRequired in reqType) {
          if (document.documentType.toString().replaceAll(' ', '') ==
              typeRequired) {
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

  int countDocsRequired(List<List<String>> documentTypes,
      List<DriverDocuments>? driverDocuments) {
    int documentsReq = 0;
    for (List<String> documentType in documentTypes) {
      if (documentType.elementAt(2).replaceAll(' ', '') == 'true') {
        documentsReq++;
      }
    }
    return documentsReq;
  }

  int countDocsUploaded(List<List<String>> documentTypes,
      List<DriverDocuments>? driverDocuments) {
    List<String> reqType = [];
    int allSubmitted = 0;
    for (List<String> documentType in documentTypes) {
      if (documentType.elementAt(2).replaceAll(' ', '') == 'true') {
        reqType.add(documentType.first.replaceAll(' ', ''));
      }
    }

    if (driverDocuments != null) {
      for (DriverDocuments document in driverDocuments) {
        for (String typeRequired in reqType) {
          if (document.documentType.toString().replaceAll(' ', '') ==
              typeRequired) {
            allSubmitted++;
          }
        }
      }
    }
    return allSubmitted;
  }
}
