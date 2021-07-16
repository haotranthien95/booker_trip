import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/getTripDataBloc.dart';
import 'package:new_ecom_project/core/services/getlisttrips_api.dart';
import 'package:new_ecom_project/ui/modules/searchPage/itemSearch/itemSearch.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key, this.textSearch = "search"})
      : super(key: key);
  final String textSearch;
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  GetTripDataBloc dataBloc = new GetTripDataBloc();

  @override
  Widget build(BuildContext context) {
    dataBloc.fetchAllTrips();
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              child: SizedBox(),
              preferredSize: Size(100, 20),
            ),
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
                              onPressed: () => print("Search pressed"),
                              icon: Icon(Icons.search_outlined)),
                          Expanded(
                              child: GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey[900]),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  widget.textSearch,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                          )),
                          IconButton(
                              constraints:
                                  BoxConstraints.expand(height: 50, width: 35),
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: Icon(Icons.close_sharp)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              StreamBuilder(
                stream: dataBloc.allTrips,
                builder: (context, AsyncSnapshot<ResponsTripsData> snapshot) {
                  if (snapshot.hasData) {
                    return buildList(snapshot);
                  } else if (snapshot.hasError) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return Center(
                          child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(color: Colors.red),
                      ));
                    }, childCount: 1));
                  }
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return Center(child: CircularProgressIndicator());
                  }, childCount: 1));
                },
              ),
            ],
          ),
        ));
  }

  Widget buildList(AsyncSnapshot<ResponsTripsData> snapshot) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return ItemSearch(tripsData: snapshot.data!.trips[index]);
    }, childCount: snapshot.data!.trips.length));
  }
}
