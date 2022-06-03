import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async {
  final ImagePicker imgpicker = ImagePicker();

  XFile? img = await imgpicker.pickImage(
      source: imageSource, imageQuality: 50, maxWidth: 100);

  if (img != null) {
    return await img.readAsBytes();
    //this method is not accesseable on internet
    //File(img.path);
  }
  print('no Image');
}
