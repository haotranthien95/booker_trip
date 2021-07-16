import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/blocs/uploadTripBloc.dart';
import 'package:new_ecom_project/core/blocs/validCreateTripBloc.dart';
import 'package:new_ecom_project/core/modules/createTripFileHelp.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/bookingSlotNewTrip/bookingSlotnewTrip.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/locationPageNewTrip/locationPageNewTrip.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/titleDateNewTrip/titleDateNewTrip.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/uploadImageNewTrip/uploadImageNewTrip.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'bookingSlotNewTrip/slotTypeController/slotObject.dart';
import 'contentNewTrip/contentNewTrip.dart';
import 'othersServiceNewTrip/othersServiceNewTrip.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:path/path.dart';

class TripCreatePage extends StatefulWidget {
  const TripCreatePage({Key? key}) : super(key: key);

  @override
  _TripCreatePageState createState() => _TripCreatePageState();
}

class _TripCreatePageState extends State<TripCreatePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final homeDirectory = path.getTemporaryDirectory();
  TripRegisterController tripRegisterController = TripRegisterController();
  UploadTripBloc uploadTripBloc = UploadTripBloc();
  ValidCreateCtripBloc validCreateCtripBloc = ValidCreateCtripBloc();
  List<String> labelList = [
    'Tạo chuyến đi mới',
    'Vị trí, địa điểm',
    'Thiết lập số chỗ',
    'Tải ảnh lên',
    'Dịch vụ khác',
    'Nội dung'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 6,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    uploadTripBloc.dispose();
    validCreateCtripBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
              bottom: PreferredSize(
                child: LinearPercentIndicator(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  percent: (_tabController.index + 1) / 6,
                ),
                preferredSize: Size(6, 6),
              ),
              title: Text(labelList[_tabController.index]),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.orange,
                    ))
              ],
              leading: IconButton(
                onPressed: () {
                  _tabController.animateTo(_tabController.index - 1);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.orange,
                ),
              ),
            ),
            bottomSheet: StreamBuilder<Map<String, dynamic>>(
                stream: validCreateCtripBloc.validationProgressController,
                initialData: {"errorMessage": [], "index": 0},
                builder: (context, snapshot) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    height: snapshot.data!["errorMessage"].isEmpty ? 120 : 160,
                    width: double.infinity,
                    child: Container(
                      child: Column(
                        children: [
                          snapshot.data!["errorMessage"].isEmpty
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!["errorMessage"][0],
                                        style: TextStyle(
                                            color: Colors.red, height: 1.2),
                                      ),
                                      snapshot.data!["errorMessage"].length > 1
                                          ? Text(
                                              snapshot.data!["errorMessage"][1],
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  height: 1.2))
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                            ),
                            onPressed: () async {
                              await validCreateCtripBloc
                                  .onValidateInfo(_tabController.index)
                                  .then((value) async {
                                if (value) {
                                  if (_tabController.index == 5) {
                                    await validCreateCtripBloc
                                        .onValidateInfoLast()
                                        .then((value) {
                                      if (value) {
                                        showDialogConfirm(context);
                                        tripRegisterController.writeCounter();
                                      }
                                    });
                                    // showDialogConfirm(context);
                                  } else {
                                    _tabController
                                        .animateTo(_tabController.index + 1);
                                    tripRegisterController.writeCounter();
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Text(
                                "Tiếp tục",
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //color: Colors.black,
                  );
                }),
            body: TabBarView(
              controller: _tabController,
              children: [
                TitleDateNewTrip(),
                LocationPageNewTrip(),
                BookingSlotNewTrip(),
                UploadImageNewTrip(),
                OthersServiceNewTrip(),
                ContentNewTrip(),
              ],
            )),
      ),
    );
  }

  checkValidation(AsyncSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.hasData) {
      _tabController.animateTo(snapshot.data!["index"]);
    }
  }

  showDialogConfirm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogUpload();
        });
  }
}

class AlertDialogUpload extends StatefulWidget {
  const AlertDialogUpload({
    Key? key,
  }) : super(key: key);

  @override
  _AlertDialogUploadState createState() => _AlertDialogUploadState();
}

class _AlertDialogUploadState extends State<AlertDialogUpload> {
  TripRegisterController tripRegisterController = TripRegisterController();
  UploadTripBloc uploadTripBloc = UploadTripBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: uploadTripBloc.uploadProgressStream,
        initialData: 0,
        builder: (context, percentSnapshot) {
          return StreamBuilder<int>(
              stream: uploadTripBloc.uploadStepStream,
              initialData: 1,
              builder: (context, stepSnapshot) {
                return AlertDialog(
                  title: Text("Đăng chuyến đi của bạn?"),
                  content:
                      contentControllerBuilder(stepSnapshot, percentSnapshot),
                  actions: [
                    ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(primary: (Colors.orange)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                        label: Text("Trở lại")),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: stepSnapshot.data == 1
                                ? Colors.green
                                : Colors.grey),
                        onPressed: () async {
                          if (stepSnapshot.data == 1) {
                            print("Accept");
                            uploadTripBloc.nextStep(2);
                            await tripRegisterController
                                .getAllFile(uploadTripBloc);
                          }
                          // Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.check),
                        label: Text("Đồng ý")),
                  ],
                );
              });
        });
  }

  Widget contentControllerBuilder(
      AsyncSnapshot<int> step, AsyncSnapshot<double> percent) {
    double percentData = percent.hasData ? percent.data! : 0;
    if (step.data == 1) {
      return Text("Quá trình này có thể mất vài phút");
    } else if (step.data == 9) {
      return Text("Đã có lỗi xảy ra");
    } else if (step.data == 3) {
      return Container(
        height: 140,
        child: Column(
          children: [
            CupertinoActivityIndicator(
              radius: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Đang đăng chuyến đi...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0))
          ],
        ),
      );
    } else if (step.data == 2) {
      return Container(
        height: 140,
        child: CircularPercentIndicator(
          animateFromLastPercent: true,
          radius: 120.0,
          lineWidth: 13.0,
          animation: true,
          percent: percentData,
          center: new Text(
            (100 * percentData).toInt().toString() + '%',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          footer: new Text(
            "Tải ảnh lên server",
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.purple,
        ),
      );
    } else if (step.data == 3) {
      return Container(
        child: CircularPercentIndicator(
          animateFromLastPercent: true,
          radius: 120.0,
          lineWidth: 13.0,
          animation: true,
          percent: percentData,
          center: new Text(
            (100 * percentData).toInt().toString() + '%',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          footer: new Text(
            "Tải ảnh lên server",
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.purple,
        ),
      );
    }
    return Text("In process");
  }
}
