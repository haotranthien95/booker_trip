import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_ecom_project/core/blocs/getTripsBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/getHotTripBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetHotTripEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/GetHotTripState.dart';
import 'package:new_ecom_project/core/services/getlisttrips_api.dart';
import 'package:new_ecom_project/ui/modules/newfeed/NewfeedCard/NewfeedCard.dart';

import 'package:new_ecom_project/ui/modules/newfeed/tran_ad_mage/TranAdImage.dart';
import 'package:new_ecom_project/ui/modules/newfeed/NewFeedBookingForm/NewFeedBookingForm.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchPage.dart';

class NewFeed extends StatefulWidget {
  const NewFeed(this.index);

  final int index;

  @override
  _NewFeedState createState() => _NewFeedState();
}

class _NewFeedState extends State<NewFeed> {
  late GetHotTripBloc getHotTripBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotTripBloc = BlocProvider.of(context);
    getHotTripBloc.add(GetHotTripEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar:
            CupertinoNavigationBar(middle: Text("Page ${widget.index}")),
        child: Center(
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    getHotTripBloc.add(GetHotTripEvent());
                  },
                ),
                SliverAppBar(
                  //onStretchTrigger: bloc.fetchAllTrips(),
                  pinned: true,
                  expandedHeight: 200,
                  backgroundColor: Colors.orange,
                  primary: true,
                  excludeHeaderSemantics: true,
                  toolbarHeight: 40,
                  stretch: true,

                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    background: TranAdImage(),
                    title: Text("Bokor Tour"),
                  ),
                ),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => SearchPage())),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        children: [
                          Container(
                              width: 50, child: Icon(Icons.search_outlined)),
                          Expanded(
                              child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[900]),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Bạn muốn đi đâu...",
                                    style: TextStyle(color: Colors.white30),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
                NewBuildAdd()
              ],
            ),
          ),
        ));
  }
}

class NewBuildAdd extends StatelessWidget {
  const NewBuildAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHotTripBloc, GetHotTripState>(
      builder: (context, state) {
        if (state is GetHotTripSuccess) {
          return SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return NewFeedCard(state.tripList[index]);
          }, childCount: state.tripList.length));
        } else if (state is GetHotTripError) {
          return SliverToBoxAdapter(
              child: Center(
                  child: Text(
            state.error.toString(),
            style: TextStyle(color: Colors.red),
          )));
        }
        return SliverToBoxAdapter(child: CircularProgressIndicator());
      },
    );
  }

  // Widget buildList(AsyncSnapshot<ResponsTripsData> snapshot) {
  //   return SliverList(
  //       delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //     return NewfeedCard(
  //         headerName: snapshot.data!.trips[index].headerName,
  //         rateStatus: snapshot.data!.trips[index].rateStatus,
  //         rateScore: snapshot.data!.trips[index].rateScore,
  //         placeAddress: snapshot.data!.trips[index].tripAddress,
  //         placeType: snapshot.data!.trips[index].tripType,
  //         slotType: snapshot.data!.trips[index].slotType,
  //         finalPrice: snapshot.data!.trips[index].finalPrice,
  //         oriPrice: snapshot.data!.trips[index].oriPrice,
  //         remainSlot: snapshot.data!.trips[index].remainSlot,
  //         promotion_1: snapshot.data!.trips[index].promotion1,
  //         promotion_2: snapshot.data!.trips[index].promotion2);
  //   }, childCount: snapshot.data!.trips.length));
  // }
}
