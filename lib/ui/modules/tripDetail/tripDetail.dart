import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/getDetailTripBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetDetailTripEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/GetTripDetailState.dart';
import 'imageBlock/imageBlock.dart';
import 'imageBlock/photoView/photoView.dart';
import 'locationBox/locationBox.dart';
import 'reviewBoxShort/reviewBoxShort.dart';

class TripDetail extends StatelessWidget {
  final String tripCode;

  const TripDetail({Key? key, required this.tripCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
        create: (BuildContext context) => GetDetailTripBloc(),
        child: DetailTripBlocBuilder(tripCode),
      ),
    );
  }
}

class DetailTripBlocBuilder extends StatefulWidget {
  const DetailTripBlocBuilder(
    this.tripCode, {
    Key? key,
  }) : super(key: key);
  final String tripCode;
  @override
  _DetailTripBlocBuilderState createState() => _DetailTripBlocBuilderState();
}

class _DetailTripBlocBuilderState extends State<DetailTripBlocBuilder> {
  late GetDetailTripBloc getDetailTripBloc;
  late Stream stream;
  late StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailTripBloc = BlocProvider.of(context);
    getDetailTripBloc.add(GetDetailTripEvent(widget.tripCode));
    stream = Stream.periodic(Duration(milliseconds: 200), (int i) {
      print("Loading");
      getDetailTripBloc.add(GetLoadingStatus());
    });
    subscription = stream.listen((event) {});
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDetailTripBloc, GetDetailTripState>(
        builder: (context, state) {
      state.dayLa();
      if (state is GetDetailTripSuccess) {
        print(
            "Loading (${state.trip.imagePath.length}/${state.trip.imageLink.length})");
        if (state.isloading) {
          if (subscription.isPaused) {
            subscription.resume();
          }
        } else {
          subscription.pause();
          print("Done");
        }
        return mainWidgetSuccessData(context, state);
      } else if (state is GetDetailTripError) {
        return Center(
            child: Text(
          state.error.toString(),
          style: TextStyle(color: Colors.red),
        ));
      }
      return Container(
        alignment: Alignment.center,
        child: Center(
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 4,
            ),
          ),
        ),
      );
    });
  }

  Scaffold mainWidgetSuccessData(
      BuildContext context, GetDetailTripSuccess state) {
    return Scaffold(
        bottomSheet: Container(
          constraints: BoxConstraints.tight(Size.fromHeight(130)),
          padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: ElevatedButton(
            onPressed: () {
              print("Booking pressed");
            },
            child: Text("Đặt chỗ ngay"),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.orange,
                  ),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
                title: Text("Bokor Adventure"),
                centerTitle: true,
                floating: true,
                actions: [
                  IconButton(
                      onPressed: () => print("Share Button pressed"),
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () => print("Share Button pressed"),
                      icon: Icon(
                        Icons.ios_share,
                        size: 30,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  print("UI:TripDetail:Refresh");
                  getDetailTripBloc.add(GetDetailTripEvent(widget.tripCode));
                },
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: ImageBlock(
                        1,
                        imageList: state.trip.imagePath,
                      ),
                      onTap: () => Navigator.of(context)
                          .push(_createRoute(state.trip.imagePath)),
                    ),
                    titleTripContainer(),
                    dateTimeTripContainer(),
                    priceTagContainer(),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: LocationMapBox(),
              ),
              SliverToBoxAdapter(
                child: ratingBoxContainer(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ReviewBoxShort();
                  },
                  childCount: 3,
                ),
              ),
              SliverFillRemaining(
                fillOverscroll: false,
                hasScrollBody: false,
                child: SizedBox(
                  height: 135,
                ),
              )
            ],
          ),
        ));
  }

  Container titleTripContainer() => Container(
        color: Colors.white12,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.fromLTRB(0, 4, 0, 3),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Text(
                "Bokor Adventure",
                textScaleFactor: 1.65,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              alignment: Alignment.center,
              child: Text(
                '7,6',
                textScaleFactor: 1.5,
              ),
            )
          ],
        ),
      );

  Container dateTimeTripContainer() => Container(
        color: Colors.white12,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text("Khởi hành", textScaleFactor: 1),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          "8:00AM Thứ 4, 9 tháng 6 ",
                          textScaleFactor: 1,
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                )),
                Container(
                  height: 40,
                  child: VerticalDivider(
                      color: Colors.grey[800],
                      endIndent: 2,
                      indent: 2,
                      thickness: 1,
                      width: 1),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text("Kết thúc", textScaleFactor: 1),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                        child: Text(
                          "8:00PM Thứ 6, 11 tháng 6 ",
                          textScaleFactor: 1,
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 8),
                  child: RichText(
                    text: TextSpan(text: 'Số lượng vé mở bán: ', children: [
                      TextSpan(text: "30", style: TextStyle(color: Colors.blue))
                    ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: RichText(
                    text: TextSpan(text: 'Khách tham gia: ', children: [
                      TextSpan(
                          text: "15 người lớn - Không có trẻ em",
                          style: TextStyle(color: Colors.blue))
                    ]),
                  ),
                )
              ],
            )
          ],
        ),
      );

  Container priceTagContainer() => Container(
        color: Colors.white12,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text("Giá tour trọn gói")),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: RichText(
                  text: TextSpan(
                      text: "1,600,000VND ",
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                      children: [
                    TextSpan(
                        text: "1,400,000VND",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white))
                  ])),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: [
                  Icon(
                    Icons.done,
                    size: 15,
                    color: Colors.green,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Đã bao gồm thuế và phí",
                      ))
                ],
              ),
            )
          ],
        ),
      );

  Container ratingBoxContainer() => Container(
        color: Colors.white12,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        alignment: AlignmentDirectional.centerStart,
        margin: EdgeInsets.fromLTRB(0, 3, 0, 6),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              alignment: Alignment.center,
              child: Text(
                '7,6',
                textScaleFactor: 1.5,
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        "Tốt",
                        textScaleFactor: 1.3,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text("Xem 72 đánh giá chi tiết"),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      );

  Route _createRoute(List<String> imagePath) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation) {
        return PhotoViewPage(imagePath);
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation,
          Widget child) {
        return child;
      },
    );
  }
}
