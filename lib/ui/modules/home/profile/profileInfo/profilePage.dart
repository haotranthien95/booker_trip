import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/loginBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/LoginStatusEvent.dart';
import 'package:new_ecom_project/core/model/userData.dart';
import 'package:new_ecom_project/core/sqlite/SqliteUserLogin.dart';

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  DatabaseUserProvider databaseProvider = DatabaseUserProvider.databaseProvider;
  UserLogin? userLogin;
  LoginStatusBloc? _loginStatusBloc;
  getloginStatus() async {
    await databaseProvider.getLoginDataObj().then((value) {
      userLogin = value;
    });
  }

  @override
  void initState() {
    getloginStatus();
    _loginStatusBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Profile")),
      child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                print("UI:ProfilePage:Refresh");
              },
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: [
                    ProfileName(),
                    SizedBox(
                      height: 10,
                    ),
                    ProfileStat(),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: buildJoinListBtn(),
                      onTap: () {
                        print("Click to show Joined Trips List");
                      },
                    ),
                    GestureDetector(
                      child: buildTripsListBtn(),
                      onTap: () {
                        print("Click to show Trips List");
                      },
                    ),
                    GestureDetector(
                      child: buildFollowerBtn(),
                      onTap: () {
                        print("Click to show Trips List");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: buildSettingBtn(),
                      onTap: () {
                        print("Click to show Setting");
                      },
                    ),
                    GestureDetector(
                      child: buildAppInfoBtn(),
                      onTap: () {
                        print("Click to show Application Info");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: buildLogOutBtn(),
                      onTap: () {
                        _loginStatusBloc!.add(LogOutEvent());
                        print("Click to show Application Info");
                      },
                    ),
                  ],
                );
              }, childCount: 1),
            )
          ],
        ),
      ),
    );
  }

  Container buildJoinListBtn() {
    return Container(
      color: Colors.white10,
      child: Column(
        children: [
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.flag,
                    size: 30,
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Joined trips",
                      textScaleFactor: 1.1,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    onTap: () => print("object")),
              )
            ],
          ),
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
            indent: 60,
          )
        ],
      ),
    );
  }

  Container buildTripsListBtn() {
    return Container(
      color: Colors.white10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.festival,
                    size: 30,
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "List of trips",
                      textScaleFactor: 1.1,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    onTap: () => print("object")),
              )
            ],
          ),
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
            indent: 60,
          )
        ],
      ),
    );
  }

  Container buildFollowerBtn() {
    return Container(
      color: Colors.white10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.group_rounded,
                    size: 30,
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Followers",
                      textScaleFactor: 1.1,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    onTap: () => print("Click to show followers")),
              )
            ],
          ),
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
          )
        ],
      ),
    );
  }

  Container buildSettingBtn() {
    return Container(
      color: Colors.white10,
      child: Column(
        children: [
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.settings,
                    size: 30,
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Setting",
                      textScaleFactor: 1.1,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    onTap: () => print("object")),
              )
            ],
          ),
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
            indent: 60,
          )
        ],
      ),
    );
  }

  Container buildAppInfoBtn() {
    return Container(
      color: Colors.white10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.info,
                    size: 30,
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Application Info",
                      textScaleFactor: 1.1,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 30,
                    ),
                    onTap: () => print("Click to show followers")),
              )
            ],
          ),
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
          )
        ],
      ),
    );
  }

  Container buildLogOutBtn() {
    return Container(
      color: Colors.white10,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.logout,
                    size: 30,
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Log Out",
                      textScaleFactor: 1.1,
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.white24,
            thickness: 0.5,
            height: 0.5,
          )
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  const ProfileStat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.group_rounded),
                      SizedBox(
                        width: 5,
                      ),
                      Text('100')
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Follower')
                ],
              )),
          VerticalDivider(
            color: Colors.white24,
            width: 2,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_up),
                      SizedBox(
                        width: 5,
                      ),
                      Text('1,000')
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Likes')
                ],
              )),
          VerticalDivider(
            color: Colors.white24,
            width: 2,
            thickness: 1,
            endIndent: 2,
            indent: 2,
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.festival),
                      SizedBox(
                        width: 5,
                      ),
                      Text('42')
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Trips')
                ],
              ))
        ],
      ),
    );
  }
}

class ProfileName extends StatelessWidget {
  const ProfileName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange,
                        border: Border.all(color: Colors.white, width: 2)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hao Tran",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "@haotran",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ]),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ),
                onTap: () => print("object")),
          ),
        ],
      ),
    );
  }
}
