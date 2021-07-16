import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'imageGallery.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage(
    this.imagePath, {
    Key? key,
  }) : super(key: key);
  final List<String> imagePath;

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  ImageGallery imageGallery = ImageGallery([
    'lib/ui/assets/image_block/camp1.jpeg',
    'lib/ui/assets/image_block/camp2.jpeg',
    'lib/ui/assets/image_block/camp3.jpeg',
    'lib/ui/assets/image_block/camp4.jpeg',
    'lib/ui/assets/image_block/camp5.jpeg'
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              iconSize: 40,
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop()),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: PhotoViewGallery.builder(
          enableRotation: false,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(widget.imagePath[index]));
          },
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          itemCount: widget.imagePath.length,
        ),
      ),
    );
  }
}
