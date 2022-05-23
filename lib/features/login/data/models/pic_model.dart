import 'package:hulutaxi_driver/features/login/domain/entities/profile_pic.dart';

class ProfilePicModel extends ProfilePic {
  const ProfilePicModel(
      {required id,
      required photo,})
      : super(id: id, photo: photo);

  factory ProfilePicModel.fromJson(json) {
    return ProfilePicModel(
      id: json['id'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "photo": photo,
    };
  }
}
