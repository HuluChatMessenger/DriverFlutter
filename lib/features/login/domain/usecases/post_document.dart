import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hulutaxi_driver/core/error/failures.dart';
import 'package:hulutaxi_driver/core/usecases/usecase.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/driver_documents.dart';
import 'package:hulutaxi_driver/features/login/domain/repositories/repositories.dart';

class PostDocument implements UseCase<Driver, Params> {
  final Repository repository;

  PostDocument(this.repository);

  @override
  Future<Either<Failure, Driver>> call(Params params) async {
    return await repository.postDocument(params.doc);
  }
}

class Params extends Equatable {
  final DriverDocuments doc;

  const Params({required this.doc});

  @override
  List<Object?> get props => [doc];
}
