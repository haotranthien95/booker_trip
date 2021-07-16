import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_ecom_project/core/blocs/changeTabBloc.dart';
// import 'package:new_ecom_project/core/blocs/loginBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/loginBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/LoginStatusEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/LoginStatusState.dart';
import 'package:new_ecom_project/core/sqlite/SqliteUserLogin.dart';
import 'package:new_ecom_project/ui/modules/home/profile/loginTab/LoginTab.dart';
import 'package:new_ecom_project/ui/modules/home/profile/profileTab.dart';
import 'package:new_ecom_project/ui/modules/newfeed/NewFeed.dart';
import 'package:new_ecom_project/ui/common/TempWidgetD.dart';
import 'package:new_ecom_project/core/blocs/getTripsBloc.dart';
import 'package:new_ecom_project/ui/modules/userPage/userMainPage.dart';

class MainPage extends StatelessWidget {
  int? _curIndex = 0;
  String? _email;
  bool? _loginStatus = false;
  LoginStatusBloc? _loginStatusBloc;
  //ChangeTabBloc changeTabBloc = new ChangeTabBloc();

  @override
  Widget build(BuildContext context) {
    _loginStatusBloc = BlocProvider.of(context);
    {
      // loginBloc.getLoginStatus();
      return BlocBuilder<LoginStatusBloc, LoginStatusState>(
          builder: (context, state) {
        _loginStatus = state is LoginStatusSuccess ? true : false;
        return CupertinoTabScaffold(
          controller: CupertinoTabController(initialIndex: 0),
          tabBar: CupertinoTabBar(
            onTap: (index) {
              _loginStatusBloc!.add(GetLoginEvent());
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: AppLocalizations.of(context)!.lblHome),
              BottomNavigationBarItem(
                  icon: Icon(Icons.festival), label: "Your Page"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bell), label: "Notification"),
              BottomNavigationBarItem(
                  icon: Icon(_loginStatus! ? Icons.person : Icons.login),
                  label: _loginStatus! ? "Profile" : "Login"),
            ],
            currentIndex: 0,
            inactiveColor: Colors.grey,
            activeColor: Colors.orange,
          ),
          tabBuilder: (BuildContext context, int index) {
            late CupertinoTabView returnValue;
            switch (index) {
              case 0:
                returnValue = CupertinoTabView(
                  builder: (BuildContext context) {
                    return NewFeed(index);
                  },
                );
                break;
              case 1:
                returnValue = CupertinoTabView(
                  builder: (BuildContext context) {
                    return UserMainPage();
                  },
                );
                break;
              case 2:
                returnValue = CupertinoTabView(
                  builder: (BuildContext context) {
                    return TempWidgetD(index);
                  },
                );
                break;
              case 3:
                returnValue = CupertinoTabView(
                  builder: (BuildContext context) {
                    return ProfileTab();
                  },
                );
                break;
            }
            return returnValue;
          },
        );
      });
    }
  }
}
