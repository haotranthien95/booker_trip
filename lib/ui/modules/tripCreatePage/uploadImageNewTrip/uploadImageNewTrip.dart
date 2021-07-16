import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart' as pat;

class UploadImageNewTrip extends StatefulWidget {
  const UploadImageNewTrip({Key? key}) : super(key: key);

  @override
  _UploadImageNewTripState createState() => _UploadImageNewTripState();
}

class _UploadImageNewTripState extends State<UploadImageNewTrip> {
  List<File> _imageList = [];
  final picker = ImagePicker();
  @override
  void initState() {
    getAllFile();
    super.initState();
  }

  // Future pickImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     _imageFile = File(pickedFile!.path);
  //     uploadImageToFirebase(context);
  //   });
  // }

  // late File _imageFile;

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = _imageFile.path;
  //   firebase_storage.Reference firebaseStorageRef = firebase_storage
  //       .FirebaseStorage.instance
  //       .ref()
  //       .child('uploads/$fileName');
  //   firebase_storage.UploadTask uploadTask =
  //       firebaseStorageRef.putFile(_imageFile);
  //   firebase_storage.TaskSnapshot taskSnapshot =
  //       await uploadTask.whenComplete(() => print("Complete"));
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
          child: Container(
              height: 200,
              color: Colors.black,
              padding: EdgeInsets.all(20),
              child: DottedBorder(
                padding: EdgeInsets.zero,
                radius: Radius.circular(12),
                color: Colors.white,
                customPath: (size) {
                  double CardRadius = 10;
                  return Path()
                    ..moveTo(CardRadius, 0)
                    ..lineTo(size.width - CardRadius, 0)
                    ..arcToPoint(Offset(size.width, CardRadius),
                        radius: Radius.circular(CardRadius))
                    ..lineTo(size.width, size.height - CardRadius)
                    ..arcToPoint(Offset(size.width - CardRadius, size.height),
                        radius: Radius.circular(CardRadius))
                    ..lineTo(CardRadius, size.height)
                    ..arcToPoint(Offset(0, size.height - CardRadius),
                        radius: Radius.circular(CardRadius))
                    ..lineTo(0, CardRadius)
                    ..arcToPoint(Offset(CardRadius, 0),
                        radius: Radius.circular(CardRadius));
                },
                dashPattern: [
                  10,
                  5,
                ],
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        primary: Color(Color.getAlphaFromOpacity(0))),
                    onPressed: () {
                      print("Selected Image");
                      //pickImage();
                      _pickImage();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.image), Text("Chọn ảnh")],
                    ),
                  ),
                ),
              ))),
      SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          color: Colors.black,
          padding: EdgeInsets.all(5),
          child: Stack(children: [
            Image(
              image: FileImage(_imageList[index]),
              fit: BoxFit.cover,
            ),
            IconButton(
                onPressed: () async {
                  print("Clear");
                  await _imageList[index].delete();
                  _imageList.removeAt(index);

                  setState(() {});
                },
                icon: Icon(Icons.close))
          ]),
        );
      }, childCount: _imageList.length)),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          height: 200,
          color: Colors.black,
        ),
      )
    ]);
  }

  // final picker = ImagePicker();

  // Future pickImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   print(pickedFile!);
  // }

  Future<void> _pickImage() async {
    DateTime dateTime = DateTime.now();
    String nameTime =
        '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}${dateTime.hour.toString().padLeft(2, '0')}${dateTime.minute.toString().padLeft(2, '0')}${dateTime.second.toString().padLeft(2, '0')}';
    int i = 1;
    final dir = await pat.getTemporaryDirectory();
    print(dir.path);
    await MultiImagePicker.pickImages(maxImages: 10, enableCamera: false)
        .then((value) async {
      print(value[0].name);
      await deleteAllFile();
      for (var asset in value) {
        print(asset.name);

        int MAXWIDTH = 1000;
        int height =
            ((MAXWIDTH * asset.originalHeight!) / asset.originalWidth!).round();
        ByteData imageData =
            await asset.getThumbByteData(MAXWIDTH, height, quality: 100);

        //Export thump
        print(dir.path);
        String fileName = "$i-$nameTime-trip.jpg";
        String fileBaseDirectory = "/tripsImage/$fileName";
        String fileLocalDirectory = "${dir.path}/$fileName";
        _imageList.add(await File("/$fileLocalDirectory")
            .writeAsBytes(imageData.buffer.asUint8List()));
        //Export thump

        // ByteData byteData =
        //     await asset.getThumbByteData(MAXWIDTH, height, quality: 100);

        // postImage(asset, MAXWIDTH, height, p.extension(asset.name!));
        //postImage(asset, MAXWIDTH, height, ".jpg");
        // List<int>? _imageByteDataList = byteData.buffer.asInt8List();
        // print(_imageByteDataList.length.toString());
        // Image.memory(Uint8List.fromList(_imageByteDataList));
        i++;
      }
    }).catchError((err) => print('Error:${err.toString()}'));
    setState(() {});
  }

  Future<dynamic> postImage(
      Asset imageFile, int width, int height, String exts) async {
    ByteData imageData =
        await imageFile.getThumbByteData(width, height, quality: 100);
    final dir = await pat.getTemporaryDirectory();
    print(dir.path);
    String fileName =
        "TRIP${DateTime.now().millisecondsSinceEpoch.toString()}$exts";
    String fileBaseDirectory = "/tripsImage/$fileName";
    String fileLocalDirectory = "${dir.path}/$fileName";
    File file = await File("/$fileLocalDirectory")
        .writeAsBytes(imageData.buffer.asUint8List());
    firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(fileBaseDirectory);
    firebase_storage.UploadTask uploadTask = reference.putFile(file);
    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await uploadTask.then((value) {
      print(value.toString());
      return value;
    });
    return storageTaskSnapshot.ref
        .getDownloadURL()
        .then((value) => print(value));
  }

  Future<void> deleteAllFile() async {
    final dir = await pat.getTemporaryDirectory();
    int count = 0;
    Iterable<FileSystemEntity> deleteList =
        Directory(dir.path).listSync().where((element) {
      //print(element.path.endsWith('-trip.jpg'));
      return element.path.endsWith('-trip.jpg');
    });
    print("DELETE LIST LENGTH: ${deleteList.length}");
    if (deleteList.isNotEmpty) {
      deleteList.forEach((element) {
        element.delete();
        count++;
      });
    }
    _imageList.clear();
    setState(() {});
    print("Delete: $count file");
  }

  Future<void> getAllFile() async {
    List<String> pathList = [];
    final dir = await pat.getTemporaryDirectory();
    Iterable<FileSystemEntity> fileList =
        Directory(dir.path).listSync().where((element) {
      //print(element.path.endsWith('-trip.jpg'));
      return element.path.endsWith('-trip.jpg');
    });
    fileList.forEach((element) {
      pathList.add(element.path);
    });
    pathList.sort();
    pathList.forEach((element) {
      _imageList.add(File(element));
    });
  }
}
