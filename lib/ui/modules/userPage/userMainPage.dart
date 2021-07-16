import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/blocs/signupBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/getUserTripBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/loginBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetUserTripEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/LoginStatusState.dart';
import 'package:new_ecom_project/ui/modules/home/page/MainPage.dart';
import 'package:new_ecom_project/ui/modules/home/profile/loginTab/LoginTab.dart';
import 'package:new_ecom_project/ui/modules/home/profile/loginTab/SignUp/SignUp.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/tripCreatePage.dart';
import 'package:new_ecom_project/ui/modules/userPage/userTrip/userTripList.dart';

import 'coverProfile/coverProfile.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  late GetUserTripBloc getUserTripBloc;
  final _scrollController = ScrollController();
  final _scrollThreadhold = 0;
  bool isLoading = false;
  @override
  void initState() {
    print("Init");
    isLoading = false;
    getUserTripBloc = BlocProvider.of(context);
    getUserTripBloc.add(GetUserTripEvent());
    _scrollController.addListener(() {
      if (!isLoading) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;

        if (maxScrollExtent - currentScroll == _scrollThreadhold) {
          getUserTripBloc.add(GetUserTripEvent());
        }
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    print("===== DEAVCTIVE");
    super.deactivate();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginStatusBloc, LoginStatusState>(
        builder: (context, state) {
      isLoading = false;
      if (state is LoginStatusInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is LogoutStatusSuccess) {
        return inLogOutStatusBuilder(context);
      } else if (state is LoginStatusSuccess) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text("Lebron James")),
          child: SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    isLoading = false;
                    getUserTripBloc.add(GetUserTripEvent(refresh: true));
                  },
                ),
                SliverToBoxAdapter(
                  child: CoverProfile(),
                ),
                newPostBuilder(),
                UserTripList(
                    hostName:
                        '${state.user["first_name"]} ${state.user["last_name"]}'),
              ],
            ),
          ),
        );
      }
      return Text("No thing");
    });
  }

  CupertinoPageScaffold inLogOutStatusBuilder(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Bokor Adventure',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Để tham gia vào cộng đồng Bokor Adventure",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("Hãy đăng nhập hoặc tạo tài khoản."),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => LoginTab(1, () {
                              Navigator.of(context).pop();
                            })));
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, bottom: 10, top: 10),
                    child: Text("Đăng Nhập"),
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    indent: 70,
                    endIndent: 10,
                  )),
                  Text(
                    "hoặc",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 70,
                  ))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.green[700]),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Tạo tài khoản mới"),
                  ))
            ],
          ),
        ),
      ),
      navigationBar: CupertinoNavigationBar(middle: Text("Bokor")),
    );
  }

  SliverToBoxAdapter newPostBuilder() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange, padding: EdgeInsets.all(10)),
                  onPressed: () {
                    showBottomSheetBuilder();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.post_add,
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            "Thêm chuyến đi mới",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ))
                    ],
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[800], padding: EdgeInsets.all(10)),
                onPressed: () => print("New Post pressed"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.more_horiz)],
                )),
          ],
        ),
      ),
    );
  }

  showBottomSheetBuilder() {
    showModalBottomSheet<void>(
        backgroundColor: Colors.white38,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 350,
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.all(5),
                  height: 20,
                  child: Container(
                    width: 70,
                    height: 7,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white60)),
                        height: 100,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white)),
                              padding: EdgeInsets.zero),
                          onPressed: () => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).push(MaterialPageRoute(
                              builder: (context) => TripCreatePage())),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Opacity(
                                opacity: 0.25,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'lib/ui/assets/button/button_1.jpeg'),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.greenAccent,
                                              BlendMode.color))),
                                ),
                              ),
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Icon(
                                        Icons.festival,
                                        size: 30,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text("Đăng chuyến đi mới",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white60)),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white)),
                              padding: EdgeInsets.zero),
                          onPressed: () => print("object"),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Opacity(
                                opacity: 0.5,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'lib/ui/assets/button/button_2.jpeg'),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.orangeAccent,
                                              BlendMode.color))),
                                ),
                              ),
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Icon(
                                        Icons.festival,
                                        size: 30,
                                        color: Colors.orange[300],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text("Đăng bài chia sẻ mới",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.orange[300],
                                              fontWeight: FontWeight.w500,
                                            ))),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
