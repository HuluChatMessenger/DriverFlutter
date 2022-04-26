import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class DriverDocumentRequest extends Equatable {
  final bool isPic;
  final String docType;
  final File? pdfDoc;
  final XFile? picDoc;

  const DriverDocumentRequest({
    required this.isPic,
    required this.docType,
    required this.pdfDoc,
    required this.picDoc,
  });

  @override
  List<Object?> get props => [
        isPic,
        docType,
        pdfDoc,
        picDoc,
      ];
}
