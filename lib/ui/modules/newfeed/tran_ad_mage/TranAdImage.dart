import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:new_ecom_project/lib/ui/modules/newfeed/tran_ad_mage/image_src/banner_1605254133.jpg'

class TranAdImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 21, keepPage: true);
    void nextPage(int mili) {
      controller.animateToPage(controller.page!.toInt() + 1,
          duration: Duration(milliseconds: mili), curve: Curves.easeIn);
    }

    var subscription = Stream.periodic(Duration(seconds: 5), (int i) {
      nextPage(1000);
    });

    return StreamBuilder(
        stream: subscription,
        builder: (context, snapshot) {
          return PageView.builder(
            allowImplicitScrolling: true,
            pageSnapping: true,
            itemBuilder: (context, position) {
              String imageLink = '';

              switch (position % 3) {
                case 0:
                  imageLink = 'lib/ui/assets/image_src/banner_1.jpg';
                  break;
                case 1:
                  imageLink = 'lib/ui/assets/image_src/banner_2.jpg';
                  break;
                case 2:
                  imageLink = 'lib/ui/assets/image_src/banner_3.jpg';
                  break;
                default:
              }
              //nextPage();
              return Container(
                child: GestureDetector(
                  child: Image(
                    image: AssetImage(imageLink),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            controller: controller,
            scrollDirection: Axis.horizontal,
          );
        });
  }
}
