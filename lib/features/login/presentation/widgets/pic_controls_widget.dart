import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/bloc.dart';

class PicControlsWidget extends StatefulWidget {
  const PicControlsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PicControlsWidgetState createState() => _PicControlsWidgetState();
}

class _PicControlsWidgetState extends State<PicControlsWidget> {
  final ImagePicker picker = ImagePicker();
  var pickedImage = CircleAvatar(
    radius: 104, // Image radius
    child: Image.asset('assets/images/place_holder_profile.png'),
  );
  String? pic;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () async {
            await showDialogImagePicker(context);
          },
          child: pickedImage,
        ),
        Positioned(
          bottom: 4,
          right: 8,
          child: Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                await showDialogImagePicker(context);
              },
              icon: const Icon(
                Icons.add,
                size: 38,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showDialogImagePicker(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 108,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 50,
                                maxWidth: 300,
                                maxHeight: 300);
                            if (image != null) setPickedImage(image);
                          },
                          icon: const Icon(
                            Icons.photo_library,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 50,
                                maxWidth: 300,
                                maxHeight: 300);
                            if (image != null) setPickedImage(image);
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void setPickedImage(XFile image) {
    pic = image.path;
    if (pic != null) {
      addPic(image);
      setState(() {
        pickedImage = CircleAvatar(
          radius: 104,
          backgroundImage: FileImage(File(pic!)),
        );
      });
    }
  }

  void addPic(XFile input) {
    BlocProvider.of<PicBloc>(context).add(GetPic(input));
  }
}
