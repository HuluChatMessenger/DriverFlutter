import 'package:hulutaxi_driver/features/login/domain/entities/profile_pic.dart';

class ProfilePicModel extends ProfilePic {
  const ProfilePicModel(
      {required int id,
      required String photo,
      required String photoAbsoluteUrl})
      : super(id: id, photo: photo, photoAbsoluteUrl: photoAbsoluteUrl);

  factory ProfilePicModel.fromJson(json) {
    return ProfilePicModel(
      id: json['id'],
      photo: json['photo'],
      photoAbsoluteUrl: json['photo_absoulteurl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "photo": photo,
      "photo_absoulteurl": photoAbsoluteUrl,
    };
  }
}
