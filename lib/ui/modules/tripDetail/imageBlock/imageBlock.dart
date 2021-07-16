import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageBlock extends StatelessWidget {
  ImageBlock(this.imageCount, {Key? key, required this.imageList})
      : super(key: key);
  final int imageCount;
  final List<String> imageList;
  @override
  Widget build(BuildContext context) {
    return buildFlexImage(imageList);
  }

  Container buildFlexImage(List<String> imageList) {
    print("imageList.length" + imageList.length.toString());
    int imgCount = imageList.length;
    if (imgCount == 0) {
      return Container();
    }
    return Container(
        margin: EdgeInsets.fromLTRB(3, 6, 3, 0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: imgCount <= 3 ? 2 : 1,
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Image.file(
                      File(imageList[0]),
                      height: imgCount > 3 ? 150 : 300,
                      fit: BoxFit.fitHeight,
                    )
                    // Image(
                    //   image: AssetImage(imageLink1),
                    //   height: imgCount > 3 ? 150 : 300,
                    //   fit: BoxFit.fitHeight,
                    // ),
                    ),
              ),
              imgCount == 1
                  ? SizedBox.shrink()
                  : Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Image.file(
                              File(imageList[1]),
                              height: imgCount > 2 ? 150 : 300,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          imgCount != 3
                              ? SizedBox.shrink()
                              : Container(
                                  padding: EdgeInsets.all(2),
                                  child: Image.file(
                                    File(imageList[2]),
                                    height: 150,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                        ],
                      ),
                    )
            ],
          ),
          imgCount < 4
              ? SizedBox.shrink()
              : Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: Image.file(
                          File(imgCount >= 4 ? imageList[2] : imageList[3]),
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: Image.file(
                          File(imageList[3]),
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    imgCount < 5
                        ? SizedBox.shrink()
                        : Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: Image.file(
                                File(imageList[4]),
                                height: 150,
                                fit: BoxFit.fitHeight,
                                color: Colors.grey[900],
                                colorBlendMode: BlendMode.hardLight,
                              ),
                            ),
                          )
                  ],
                )
        ]));
  }
}
