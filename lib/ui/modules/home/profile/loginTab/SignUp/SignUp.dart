import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ecom_project/core/modules/hash_pw.dart';
import 'package:new_ecom_project/core/services/signup_api_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignUpAPIProvider signUpProvider = SignUpAPIProvider();
    return Scaffold(
        body: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Sign Up")),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 20, color: Colors.orange),
              )),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black,
                labelStyle: TextStyle(color: Colors.white54),
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: firstNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black,
                labelStyle: TextStyle(color: Colors.white54),
                labelText: 'First Name',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: lastNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black,
                labelStyle: TextStyle(color: Colors.white54),
                labelText: 'Last Name',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
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
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              controller: rePasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white54),
                labelText: 'Confirm Password',
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ),
          Container(
            height: 25,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange)),
                child: Text('Register', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  print(emailController.text);
                  print(firstNameController.text);
                  print(lastNameController.text);
                  //String adada = saltEnc.convertSalt("cscds");
                  print(saltEnc.convertSalt(passwordController.text));
                  print(saltEnc.convertSalt(rePasswordController.text));
                  signUpProvider
                      .getSignUpInfo(
                    emailController.text,
                    firstNameController.text,
                    lastNameController.text,
                    saltEnc.convertSalt(passwordController.text),
                    saltEnc.convertSalt(rePasswordController.text),
                  )
                      .then((response) {
                    print("Nono");
                    if (response['status']) {
                      return Navigator.of(context).pop();
                    } else {
                      Flushbar(
                        title: "Registration Failed",
                        message: "Registration Failed",
                        duration: Duration(seconds: 10),
                      ).show(context);
                    }
                  });
                },
              ))
        ],
      ),
    ));
  }
}
