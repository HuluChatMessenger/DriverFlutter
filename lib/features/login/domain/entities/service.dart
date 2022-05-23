import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int service;
  final int paymentProvider;

  const Service({
    required this.service,
    required this.paymentProvider,
  });

  @override
  List<Object?> get props => [
        service,
        paymentProvider,
      ];
}
