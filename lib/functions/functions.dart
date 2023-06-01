import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class MyFunctions {
  /// Get Image From Gallery
  getFromGallery() async {
    final picker = ImagePicker();

    // use the image picker to pick image from Gallery
    var file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    // convert the picked image to Multipart file to upload using http
    var mFile = MultipartFile.fromBytes(
        "Image", File(file?.path ?? "").readAsBytesSync(),
        filename: 'Image.png');
    return mFile;
  }

  noImageField(context, bool lang) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(lang ? 'Error' : "خطأ"),
              content:
                  Text(lang ? 'Image field is required' : "حقل الصورة مطلوب"),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 69, 109, 179)),
                    child: Text(
                      lang ? 'Close' : "إغلاق",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
