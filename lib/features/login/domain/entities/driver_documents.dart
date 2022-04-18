import 'package:equatable/equatable.dart';

class DriverDocuments extends Equatable {
  final int id;
  final int documentType;

  const DriverDocuments({
    required this.id,
    required this.documentType,
  });

  @override
  List<Object?> get props => [
        id,
        documentType,
      ];
}
