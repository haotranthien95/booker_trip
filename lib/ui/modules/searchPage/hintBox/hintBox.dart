import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/searchingHintBloc.dart';
import 'package:new_ecom_project/ui/modules/searchPage/hintBox/hintType.dart';

class HintBox extends StatelessWidget {
  const HintBox({
    Key? key,
    required this.bloc,
    required this.hintType,
    required this.getText,
    required this.onRemoveHistory,
  }) : super(key: key);
  final Stream<List<String>> bloc;
  final HintTypeIcon hintType;
  final Function(String text) getText;
  final Function(String text) onRemoveHistory;

  //SearchingHintBloc bloc = SearchingHintBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: bloc,
        builder: (context, snapshot) {
          return SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return SizedBox(
              child: HintItem(
                onClear: () => onRemoveHistory(snapshot.data![index]),
                onTap: () => getText(snapshot.data![index]),
                key: UniqueKey(),
                title:
                    snapshot.hasData ? snapshot.data![index] : "Lebron James",
                type: hintType,
                image: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("lib/ui/assets/image_block/camp1.jpeg"),
                ),
              ),
            );
          }, childCount: snapshot.hasData ? snapshot.data!.length : 2));
        });
  }
}
