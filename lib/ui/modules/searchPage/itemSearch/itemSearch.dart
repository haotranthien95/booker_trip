import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_ecom_project/core/services/getlisttrips_api.dart';
import 'package:new_ecom_project/ui/modules/tripDetail/tripDetail.dart';

class ItemSearch extends StatelessWidget {
  ItemSearch({required this.tripsData});
  final Trips tripsData;

  @override
  Widget build(BuildContext context) {
    rateStatusRender(String rateStatus) {
      if (rateStatus == "10") {
        return Icon(Icons.star);
      } else {
        return Icon(Icons.star_border_outlined);
      }
    }

    return GestureDetector(
      onTap: () => Navigator.of(
        context,
        rootNavigator: true,
      ).push(MaterialPageRoute(
          builder: (context) => TripDetail(
                tripCode: "tripsData.tripCode",
              ))),
      child: Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
                image: AssetImage('lib/ui/assets/image_src/banner_2.jpg'),
                width: 120,
                height: 250,
                fit: BoxFit.fitHeight),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(8),
                //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 5),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                child: Text(
                              tripsData.headerName,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ))),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: rateStatusRender(tripsData.rateStatus!),
                              alignment: Alignment.centerRight,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 10),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Text(
                              tripsData.rateScore.toString(),
                              style: TextStyle(fontSize: 14),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  "Good",
                                  style: TextStyle(fontSize: 14),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Icon(
                            Icons.location_pin,
                            size: 20,
                          ),
                          alignment: Alignment.centerLeft,
                        )),
                        Expanded(
                            flex: 9,
                            child: Container(
                                child: Text(
                              tripsData.tripAddress!,
                              style: TextStyle(fontSize: 12),
                            ))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Icon(
                            Icons.park,
                            size: 20,
                          ),
                          alignment: Alignment.centerLeft,
                        )),
                        Expanded(
                            flex: 9,
                            child: Container(
                                child: Text(
                              tripsData.tripType,
                              style: TextStyle(fontSize: 12),
                            ))),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                      alignment: Alignment.centerRight,
                      child: Text(
                        tripsData.slotType,
                        style: TextStyle(fontSize: 11),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            child: Text(
                          tripsData.oriPrice,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        )),
                        Container(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              tripsData.finalPrice,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Icon(
                            Icons.done,
                            color: Colors.green[600],
                            size: 20,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                            child: Text(
                          tripsData.promotion1,
                          style: TextStyle(fontSize: 12),
                        )),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Only ${tripsData.remainSlot} slots left at this price on our site.",
                        style: TextStyle(fontSize: 11, color: Colors.red),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        tripsData.promotion2,
                        style: TextStyle(fontSize: 12),
                      )),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
