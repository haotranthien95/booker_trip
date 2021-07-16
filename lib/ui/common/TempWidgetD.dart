import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TempWidgetD extends StatelessWidget {
  const TempWidgetD(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text("Page $index")),
        child: Center(
          child: Text("Waiting"),
        ));
  }
}
