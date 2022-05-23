import 'package:hulutaxi_driver/features/login/domain/entities/hulu_coin.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/login.dart';
import 'package:hulutaxi_driver/features/login/domain/entities/service.dart';

class ServiceModel extends Service {
  const ServiceModel({required service, required paymentProvider})
      : super(service: service, paymentProvider: paymentProvider);

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(service: json['service'], paymentProvider: json['payment_provider']);
  }

  Map<String, dynamic> toJson() {
    return {
      "service": service,
      "payment_provider": paymentProvider,
    };
  }
}
