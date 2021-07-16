import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/blocs/changeTabBloc.dart';
import 'package:new_ecom_project/core/blocs/getTripsBloc.dart';
// import 'package:new_ecom_project/core/blocs/loginBloc.dart';
import 'package:new_ecom_project/core/blocs/loginValidBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/loginBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/LoginStatusEvent.dart';
import 'package:new_ecom_project/core/modules/hash_pw.dart';
import 'package:new_ecom_project/ui/modules/home/page/MainPage.dart';
import 'package:new_ecom_project/core/services/getlisttrips_api.dart';

import 'SignUp/SignUp.dart';

class LoginTab extends StatefulWidget {
  final int index;
  const LoginTab(this.index, this.onSubmit);
  final Function onSubmit;

  @override
  _State createState() => _State(index);
}

class _State extends State<LoginTab> {
  LoginValidBloc blocLogin = new LoginValidBloc();
  late LoginStatusBloc _loginStatusBloc;
  final int index;
  _State(this.index);
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    blocLogin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loginStatusBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //GetTripsListProvider getTrip = new GetTripsListProvider();
    //ChangeTabBloc changeTabBloc = new ChangeTabBloc();
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text("Page $index")),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Bokor',
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                  stream: blocLogin.userController,
                  builder: (context, snapshot) => TextField(
                        controller: nameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.black,
                          labelStyle: TextStyle(color: Colors.white54),
                          labelText: 'Username or Email',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24)),
                        ),
                      )),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: StreamBuilder(
                  stream: blocLogin.passController,
                  builder: (context, snapshot) => TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.white54),
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24)),
                    ),
                  ),
                )),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  //color: Colors.orange,
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (blocLogin.isValidInfor(
                        nameController.text, passwordController.text)) {
                      print("object");
                      changeViewBloc.tabChangeTo(0);
                      //bloc.fetchAllTrips();
                      _loginStatusBloc.add(DoLoginEvent(nameController.text,
                          saltEnc.convertSalt(passwordController.text)));
                      // loginBloc.onLoginController(nameController.text,
                      //     saltEnc.convertSalt(passwordController.text));
                      widget.onSubmit();
                      //uper.dispose();
                      print("DOne outside");
                    }
                  },
                )),
            Container(
                child: Row(
              children: <Widget>[
                Text(
                  'Does not have account?',
                  style: TextStyle(color: Colors.white),
                ),
                FlatButton(
                  textColor: Colors.deepOrange,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.of(context).push(CupertinoPageRoute<void>(
                        builder: (BuildContext context) {
                      return SignUpPage();
                    }));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
          ],
        ),
      ),
    );
  }
}
