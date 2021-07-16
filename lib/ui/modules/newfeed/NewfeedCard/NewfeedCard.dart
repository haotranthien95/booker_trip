import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_ecom_project/core/model/hotTripData.dart';
import 'package:new_ecom_project/ui/modules/tripDetail/tripDetail.dart';

class NewFeedCard extends StatelessWidget {
  NewFeedCard(this.data);
  final HotTripObject data;

  @override
  Widget build(BuildContext context) {
    String schedule =
        "${data.startDate.day} Th.${data.startDate.month}, ${data.startDate.year} đến ${data.toDate.day} Th.${data.toDate.month}, ${data.toDate.year}";
    rateStatusRender(boolrateStatus) {
      if (data.rateStatus) {
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
                tripCode: data.tripCode,
              ))),
      child: Container(
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.grey[900],
              alignment: Alignment.center,
              height: 280,
              width: 120,
              child: Image.network(data.imageLink,
                  errorBuilder: (context, err, stack) {
                return Icon(Icons.image_not_supported);
              }, width: 120, height: 280, fit: BoxFit.fitHeight),
            ),
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
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      data.headerName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(data.hostName,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: rateStatusRender(data.rateStatus),
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
                              data.rateScore.toStringAsFixed(1),
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      schedule,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent),
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
                              data.placeAddress,
                              style: TextStyle(fontSize: 12),
                            ))),
                      ],
                    ),
                  ),
                  data.placeType == ""
                      ? SizedBox()
                      : Container(
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
                                    data.placeType,
                                    style: TextStyle(fontSize: 12),
                                  ))),
                            ],
                          ),
                        ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                      alignment: Alignment.centerRight,
                      child: Text(
                        data.slotType,
                        style: TextStyle(fontSize: 11),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        data.oriPrice == ""
                            ? SizedBox()
                            : Container(
                                child: Text(
                                data.oriPrice,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough),
                              )),
                        Container(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              (data.oriPrice == ""
                                      ? data.finalPrice
                                      : data.oriPrice) +
                                  " VND",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  data.promotion_1 == ""
                      ? SizedBox()
                      : Container(
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
                                data.promotion_1,
                                style: TextStyle(fontSize: 12),
                              )),
                            ],
                          ),
                        ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Chỉ còn ${data.remainSlot} xuất đăng ký cho chuyến đi này.",
                        style: TextStyle(fontSize: 11, color: Colors.red),
                      )),
                  data.promotion_2 == ""
                      ? SizedBox()
                      : Container(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            data.promotion_2,
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
