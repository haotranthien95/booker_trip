import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TabViewBloc {
  //StreamController _tabChangeController = new StreamController();

  final _tabViewController = StreamController<ChangetabData>();
  final _tabLoginViewController = StreamController();
  //final _tabChangeController = PublishSubject<int>();

  Stream<ChangetabData> get tabChange => _tabViewController.stream;
  //Observable<int> get tabChange => _tabChangeController.stream;

  tabChangeTo(int tab) {
    _tabViewController.sink
        .add(ChangetabData(changeTabIndex: true, tabIndex: tab));
    print("Add $tab");
  }

  loginStatusChangeTo(bool status) {
    _tabViewController.sink
        .add(ChangetabData(changeLoginStatus: true, loginStatus: status));
  }

  void dispose() {
    print('ChangeTabBloc:Dispose');

    _tabViewController.close();
  }

  //Stream get tabChangeController => _tabChangeController.stream;
}

class ChangetabData {
  bool? changeLoginStatus;
  bool? loginStatus;
  bool? changeTabIndex;
  int? tabIndex;
  bool? changeEmail;
  String? email;
  ChangetabData(
      {this.changeLoginStatus = false,
      this.loginStatus,
      this.changeEmail = false,
      this.email,
      this.changeTabIndex = false,
      this.tabIndex});

  get getchangeLoginStatus => changeLoginStatus;
  get getloginStatus => loginStatus;
  get getchangeTabIndex => changeTabIndex;
  get gettabIndex => tabIndex;
  get getchangeEmail => changeEmail;
  get getemail => email;
}

final changeViewBloc = TabViewBloc();
