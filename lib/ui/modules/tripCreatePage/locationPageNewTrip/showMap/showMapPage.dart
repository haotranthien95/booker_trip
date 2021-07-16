import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/changeLocationBloc.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({
    Key? key,
    required this.changeLocationBloc,
    required this.currentLatLng,
  }) : super(key: key);

  final ChangeLocationBloc changeLocationBloc;
  final LatLng currentLatLng;

  @override
  _FlutterMapWidgetState createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  ChangeLocationMapBloc changeLocationMapBloc = ChangeLocationMapBloc();
  late LatLng selectLatLng;
  @override
  void dispose() {
    changeLocationMapBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectLatLng = widget.currentLatLng;
    return StreamBuilder<LatLng>(
        stream: changeLocationMapBloc.changeLocationMapStream,
        builder: (context, snapshot) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.all(10),
            backgroundColor: Colors.black87,
            title: Stack(children: [
              Text("Chọn vị trí của bạn"),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(maxHeight: 30), //height of IconButton
                    onPressed: () {
                      Navigator.of(context).pop();
                      print("cho tao ra");
                    },
                    icon: Icon(Icons.close)),
              ),
            ]),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: double.infinity,
              width: 800,
              child: Stack(children: [
                FlutterMap(
                  options: MapOptions(
                      center: snapshot.hasData ? snapshot.data! : selectLatLng,
                      zoom: 10,
                      onLongPress: (latLng) {
                        selectLatLng = latLng;
                        //widget.changeLocationBloc.onChangeLocation(latLng);
                        changeLocationMapBloc.onChangeMapLocation(latLng);
                      }),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 200.0,
                          height: 200.0,
                          point:
                              snapshot.hasData ? snapshot.data! : selectLatLng,
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      color: Colors.black54,
                      child: Text(
                        "Chạm và giữ lâu trên bản đồ để chọn vị trí",
                        textScaleFactor: 0.8,
                      ),
                    ),
                    snapshot.hasData
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            color: Colors.black54,
                            child: Text(
                              "Tọa độ bạn đang chọn: (${selectLatLng.latitude.toStringAsFixed(6)},${selectLatLng.longitude.toStringAsFixed(6)})",
                              textScaleFactor: 0.8,
                            ),
                          )
                        : Container(),
                  ],
                )
              ]),
            ),
            actions: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: (Colors.orange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  label: Text("Trở lại")),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: snapshot.hasData ? Colors.green : Colors.grey),
                  onPressed: () {
                    if (snapshot.hasData) {
                      widget.changeLocationBloc.onChangeLocation(selectLatLng);
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.check),
                  label: Text("Xác nhận")),
            ],
          );
        });
  }
}
