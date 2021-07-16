import 'package:flutter/material.dart';

class HintItem extends StatelessWidget {
  const HintItem(
      {Key? key,
      @required this.type,
      this.image,
      this.title,
      required this.onTap,
      required this.onClear})
      : super(
          key: key,
        );
  final HintTypeIcon? type;
  final Image? image;
  final String? title;
  final Function onTap;
  final Function onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  primary: Colors.grey[100],
                  shadowColor: Colors.grey[850],
                  side: BorderSide.none),
              onPressed: () => onTap(),
              child: Row(
                children: [
                  iconBuilder(type!),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      title!,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: 50,
              child: type == HintTypeIcon.find
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        print('key:${key.toString()}');
                        print('context:${context.toString()}');
                        onClear();
                      },
                      icon: Icon(Icons.close)))
        ],
      ),
    );
  }

  Container iconBuilder(HintTypeIcon type) {
    return Container(
      height: 50,
      width: 50,
      child: type.type! < 3
          ? type.icon
          : Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ClipRRect(
                child: image,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
    );
  }
}

class HintTypeIcon {
  const HintTypeIcon({this.icon, this.type});
  final Icon? icon;
  final int? type;

  static HintTypeIcon history =
      HintTypeIcon(icon: Icon(Icons.access_time), type: 1);
  static HintTypeIcon find = HintTypeIcon(icon: Icon(Icons.search), type: 2);
  static HintTypeIcon findAvatar =
      HintTypeIcon(icon: Icon(Icons.search), type: 3);
  Icon get _icon => icon!;
  int get _type => type!;
}
