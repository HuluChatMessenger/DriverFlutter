import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/configuration.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DocumentState extends Equatable {
  const DocumentState();
}

class DocumentInitial extends DocumentState {
  @override
  List<Object> get props => [];
}

class EmptyDocument extends DocumentState {
  @override
  List<Object?> get props => [];
}

class LoadingDocument extends DocumentState {
  @override
  List<Object?> get props => [];}

class LoadedDocument extends DocumentState {
  final Configuration? configuration;
  final List<DriverDocuments> documents;

  const LoadedDocument({required this.documents, this.configuration});

  @override
  List<Object> get props => [];
}

class ErrorDocument extends DocumentState {
  final String message;

  const ErrorDocument({required this.message});

  @override
  List<Object> get props => [];
}

