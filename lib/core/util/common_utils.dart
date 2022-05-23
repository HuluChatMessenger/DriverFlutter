import 'package:hulutaxi_driver/core/util/constants.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:intl/intl.dart';

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

  static String checkMode(String t) {
    if (int.parse(t) <= 12) {
      return "AM";
    } else {
      return "PM";
    }
  }

  static String checkTime(String t) {
    if (int.parse(t.split(":")[0]) < 12) {
      return t;
    } else {
      int hr = (int.parse(t.split(":").elementAt(0)) - 12);
      String min = t.split(":").elementAt(1);
      return hr.toString() + ":" + min;
    }
  }

  static String formatCurrency(String price) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    // final oCcy = NumberFormat.simpleCurrency(locale: 'en_US');

    double priceNum = 0.0;
    try {
      priceNum = double.parse(price);
    } catch (e) {
      print("LogHulu Currency Conversion: $e , $price");
    }

    double priceValue = priceNum;

    if (priceNum.isNegative) {
      priceValue = priceValue * -1;
    }

    if (priceValue > 0.0) {
      return oCcy.format(priceNum);
    } else {
      return price;
    }
  }

  static DateTime getToday() {
    String todayTxt = geStringFromDate(DateTime.now());
    return getDateFromString(todayTxt);
  }

  static String geStringFromDate(DateTime date) {
    DateFormat s = DateFormat(AppConstants.isoDateTimeFormat);
    try {
      return s.format(date);
    } catch (e) {
      print("LogHulu Date now: $e");
      return date.toString();
    }
  }

  static DateTime getDateFromString(String date) {
    DateFormat s = DateFormat(AppConstants.isoDateTimeFormat);
    try {
      return s.parse(date);
    } catch (e) {
      print("LogHulu Date: $e");
      return DateTime.now();
    }
  }

  static DateTime getDateFromStringISO(String date) {
    DateFormat s = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ");
    try {
      return s.parse(date);
    } catch (e) {
      print("LogHulu Date: $e");
      return DateTime.now();
    }
  }

  static int getTimeInMill(String dateStr) {
    try {
      String DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'";
      DateFormat dateFormat = DateFormat(DATE_FORMAT);
      DateTime serverDate = dateFormat.parse(dateStr);
      if (serverDate != null) {
        return serverDate.millisecondsSinceEpoch;
      }
    } catch (e) {
      print("LogHulu Date: $e");
    }
    return 0;
  }

  static bool sameDay(DateTime date, DateTime otherDate) {
    return date.day == otherDate.day &&
        date.month == otherDate.month &&
        date.year == otherDate.year;
  }
}
