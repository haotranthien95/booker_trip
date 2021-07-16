import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/searchingHintBloc.dart';
import 'package:new_ecom_project/core/blocs/searchingHistoryBloc.dart';
import 'package:new_ecom_project/core/services/repository.dart';
import 'package:new_ecom_project/ui/modules/searchPage/hintBox/hintBox.dart';
import 'package:new_ecom_project/ui/modules/searchPage/hintBox/hintType.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchPageProvider.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchResultPage/searchResultpage.dart';
import 'package:provider/provider.dart';
import 'searchFilter/searchFilter.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchingHintBloc searchingHintBloc = new SearchingHintBloc();
  SearchingHistoryBloc searchingHistoryBloc = new SearchingHistoryBloc();
  TextEditingController textControllder = TextEditingController();
  final _repository = Repository();
  @override
  void dispose() {
    print("Dispose Searchpage");
    super.dispose();
    searchingHintBloc.dispose();
    searchingHistoryBloc.dispose();
  }

  @override
  void initState() {
    searchingHintBloc.onGetHotKeyWord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchPageProvider = context.read<SearchPageProvider>();

    searchingHistoryBloc.onChangeText("");
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          flexibleSpace: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.orange,
                    )),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        IconButton(
                            constraints:
                                BoxConstraints.expand(height: 50, width: 35),
                            onPressed: () {
                              _repository.searchText(textControllder.text);
                              searchingHistoryBloc
                                  .onSearch(textControllder.text);
                              Navigator.of(context, rootNavigator: false).push(
                                  MaterialPageRoute(
                                      builder: (context) => SearchResultPage(
                                          textSearch: textControllder.text)));
                            },
                            icon: Icon(Icons.search_outlined)),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: CupertinoTextField(
                                  autofocus: true,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (text) {
                                    _repository.searchText(text);
                                    searchingHistoryBloc.onSearch(text);
                                    Navigator.of(context, rootNavigator: false)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                SearchResultPage(
                                                    textSearch:
                                                        textControllder.text)));
                                  },
                                  onChanged: (text) {
                                    print(text);
                                    searchPageProvider.closeFilter();
                                    searchingHistoryBloc.onChangeText(text);
                                    searchingHintBloc.onChangeText(text);
                                  },
                                  controller: textControllder,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[900]),
                                  placeholder: "Bạn muốn đi đâu...",
                                  style: TextStyle(color: Colors.white),
                                  clearButtonMode:
                                      OverlayVisibilityMode.editing,
                                ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            child: Container(
              height: 30,
              margin: EdgeInsets.only(right: 10),
              alignment: AlignmentDirectional.topEnd,
              child: TextButton(
                onPressed: () {
                  searchPageProvider.switchFilter();
                  print(
                      "Add more filter pressed:${searchPageProvider.filterOn.toString()}");
                },
                child: Consumer<SearchPageProvider>(
                  builder: (context, searchPageProvider, child) {
                    print(
                        "Text Consumer:${searchPageProvider.filterOn.toString()}");
                    return searchPageProvider.filterOn
                        ? Text(
                            "Ẩn điều kiện tìm kiếm",
                            style: TextStyle(
                              height: 1,
                            ),
                          )
                        : Text(
                            "Thêm điều kiện tìm kiếm",
                            style: TextStyle(
                              height: 1,
                            ),
                          );
                  },
                ),
              ),
            ),
            preferredSize: Size(100, 20),
          ),
        ),
        body: SafeArea(
            child: Container(
                child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Consumer<SearchPageProvider>(
                  builder: (context, searchPageProvider, child) {
                    print("Consumer:${searchPageProvider.filterOn.toString()}");
                    return searchPageProvider.filterOn
                        ? SearchFilter()
                        : SizedBox();
                  },
                  child:
                      searchPageProvider.filterOn ? SearchFilter() : SizedBox(),
                ),
                // OutlinedButton(
                //     onPressed: () => searchingHintBloc.dispose(),
                //     child: Text("dispose"))
              ],
            ),
          ),
          textLabel("Tìm kiếm gần đây",
              searchingHistoryBloc.onnableHistoryLabelCall, true),
          HintBox(
            onRemoveHistory: (text) => searchingHistoryBloc.clearHistory(text),
            getText: (text) {
              textControllder.text = text;
              searchPageProvider.closeFilter();
              searchingHistoryBloc.onChangeText(text);
              searchingHintBloc.onChangeText(text);
            },
            bloc: searchingHistoryBloc.onHistoryCall,
            hintType: HintTypeIcon.history,
          ),
          textLabel("Phổ biến", searchingHintBloc.onnableHintLabelCall, true),
          HintBox(
            onRemoveHistory: (text) => print("Nothing"),
            getText: (text) {
              textControllder.text = text;
              searchPageProvider.closeFilter();
              searchingHistoryBloc.onChangeText(text);
              searchingHintBloc.onChangeText(text);
            },
            bloc: searchingHintBloc.onHintCall,
            hintType: HintTypeIcon.find,
          ),
        ]))),
      ),
    );
  }

  StreamBuilder textLabel(String text, Stream<bool> enable, bool initialData) {
    return StreamBuilder<bool>(
        stream: enable,
        initialData: initialData,
        builder: (context, snapshot) {
          return SliverToBoxAdapter(
            child: snapshot.data!
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      text,
                      textScaleFactor: 1.6,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ))
                : SizedBox(),
          );
        });
  }
}
