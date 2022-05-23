import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PicEvent extends Equatable {
  const PicEvent([List props = const <dynamic>[]]);
}

class GetPic extends PicEvent {
  final XFile pic;

  GetPic(this.pic) : super([pic]);

  @override
  List<Object> get props => [pic];
}
