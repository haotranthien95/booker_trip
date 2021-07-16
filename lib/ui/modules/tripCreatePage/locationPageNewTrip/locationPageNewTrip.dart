import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:new_ecom_project/core/blocs/changeLocationBloc.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'dart:math';

import 'showMap/showMapPage.dart';

class LocationPageNewTrip extends StatefulWidget {
  const LocationPageNewTrip({Key? key}) : super(key: key);

  @override
  _LocationPageNewTripState createState() => _LocationPageNewTripState();
}

class _LocationPageNewTripState extends State<LocationPageNewTrip> {
  ChangeLocationBloc changeLocationBloc = ChangeLocationBloc();
  LatLng _currentLatLng = LatLng(11.276212, 107.866035);
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _townController = TextEditingController();
  TextEditingController _villageController = TextEditingController();

  @override
  void dispose() {
    changeLocationBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _provinceController.text = tripController.addressProvince;
    _townController.text = tripController.addressTown;
    _villageController.text = tripController.addressVillage;
    if (tripController.location.latitude != 0 &&
        tripController.location.longitude != 0) {
      changeLocationBloc.onChangeLocation(tripController.location);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LatLng>(
        stream: changeLocationBloc.changeLocationMainStream,
        //initialData: _currentLatLng,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: addressInputBuilder(),
              ),
              SliverToBoxAdapter(child: placeInputBuilder(snapshot))
            ],
          );
        });

    // return CustomScrollView(
    //   slivers: [
    //     SliverToBoxAdapter(
    //       child: ElevatedButton(
    //         child: Text("Please Press"),
    //         // onPressed: () => staticMapLink(11.276212, 107.866035, 10),
    //         onPressed: () => staticMapLink(11.276212, 107.866035, 10),
    //       ),
    //     )
    //   ],
    // );

    // return Container(
    //   child: FlutterMap(
    //     options: MapOptions(
    //       center: LatLng(13, 13),
    //       zoom: 17,
    //     ),
    //     layers: [
    //       TileLayerOptions(
    //           urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    //           subdomains: ['a', 'b', 'c']),
    //       MarkerLayerOptions(
    //         markers: [
    //           Marker(
    //             width: 80.0,
    //             height: 80.0,
    //             point: LatLng(11.276212, 107.866035),
    //             builder: (ctx) => Container(
    //               child: Icon(Icons.location_pin),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  Future<dynamic> showMapLocationSelect(
      BuildContext context, AsyncSnapshot<LatLng> snapshot) {
    return showDialog(
        useSafeArea: true,
        barrierDismissible: false,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return FlutterMapWidget(
            changeLocationBloc: changeLocationBloc,
            currentLatLng: tripController.location,
          );
        });
  }

  void staticMapLink(double lat, double lon, int zoom) {
    double doubleX;
    double doubleY;
    int x;
    int y;
    int z = zoom;
    doubleX = ((lon + 180) / 360 * (1 << zoom));
    x = doubleX.toInt();
    //print(lat * pi / 180);
    // print(x.toInt().toString());
    doubleY = (1 - log(tan(lat * pi / 180) + 1 / (cos(lat * pi / 180))) / pi) /
        2 *
        (1 << zoom);
    y = doubleY.toInt();
    // print(y.toInt().toString());
    print("https://a.tile-cyclosm.openstreetmap.fr/cyclosm/$z/$x/$y.png");
  }

  List<String> listStaticXY(LatLng latLng, int zoom) {
    double doubleX;
    double doubleY;
    double lat = latLng.latitude;
    double lon = latLng.longitude;
    int x;
    int y;
    int z = zoom;
    doubleX = ((lon + 180) / 360 * (1 << zoom));
    List<String> result = [];
    x = doubleX.toInt();
    //print(lat * pi / 180);
    // print(x.toInt().toString());
    doubleY = (1 - log(tan(lat * pi / 180) + 1 / (cos(lat * pi / 180))) / pi) /
        2 *
        (1 << zoom);
    y = doubleY.toInt();
    // print(y.toInt().toString());
    for (int ix = -1; ix < 2; ix++) {
      for (int iy = -1; iy < 1; iy++) {
        // result.add(<int>[x - ix, y - -iy]);
        result.add(
            "https://a.tile-cyclosm.openstreetmap.fr/cyclosm/${z}/${x + ix}/${y + iy}.png");
      }
    }
    //print(result[1].toString());
    return result;
  }

  Container blockImageBuild(LatLng latLng, int zoom) {
    List<String> linkList = listStaticXY(latLng, zoom);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: imageTileBuild(linkList[0])),
              Expanded(child: imageTileBuild(linkList[2])),
              Expanded(child: imageTileBuild(linkList[4])),
            ],
          ),
          Row(
            children: [
              Expanded(child: imageTileBuild(linkList[1])),
              Expanded(child: imageTileBuild(linkList[3])),
              Expanded(child: imageTileBuild(linkList[5])),
            ],
          ),
        ],
      ),
    );
  }

  AspectRatio imageTileBuild(String link) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Image.network(
        link,
      ),
    );
  }

  Container addressInputBuilder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              alignment: AlignmentDirectional.centerStart,
              child: Text("Nơi tọa lạc",
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]))),
          CupertinoTextField(
            controller: _provinceController,
            onChanged: (text) {
              tripController.addressProvince = text;
            },
            autofocus: true,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            placeholder: "Tỉnh/Thành phố",
            style: TextStyle(color: Colors.white),
            clearButtonMode: OverlayVisibilityMode.editing,
          ),
          SizedBox(height: 13),
          CupertinoTextField(
            controller: _townController,
            onChanged: (text) {
              tripController.addressTown = text;
            },
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            placeholder: "Quận/Huyện",
            style: TextStyle(color: Colors.white),
            clearButtonMode: OverlayVisibilityMode.editing,
          ),
          SizedBox(height: 13),
          CupertinoTextField(
            controller: _villageController,
            onChanged: (text) {
              tripController.addressVillage = text;
            },
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            placeholder: "Phường/Xã",
            style: TextStyle(color: Colors.white),
            clearButtonMode: OverlayVisibilityMode.editing,
          )
        ],
      ),
    );
  }

  Container placeInputBuilder(AsyncSnapshot<LatLng> snapshot) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              alignment: AlignmentDirectional.centerStart,
              child: Text("Vị trí",
                  style: TextStyle(fontSize: 18, color: Colors.grey[200]))),
          Container(
            color: Colors.grey[700],
            child: GestureDetector(
              onTap: () {
                showMapLocationSelect(context, snapshot);
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  blockImageBuild(
                      snapshot.hasData ? snapshot.data! : _currentLatLng, 10),
                  Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    color: snapshot.hasData
                        ? Colors.green.withOpacity(0.75)
                        : Colors.orangeAccent.withOpacity(0.75),
                    child: Center(
                      child: Text(
                        snapshot.hasData ? "Thay đổi vị trí" : "Chọn vị trí",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
