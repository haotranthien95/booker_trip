import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/blocs/changeTabBloc.dart';
// import 'package:new_ecom_project/core/blocs/loginBloc.dart' as bloc;
import 'package:new_ecom_project/core/flutter_bloc/bloc/loginBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/LoginStatusState.dart';
import 'package:new_ecom_project/core/model/userData.dart';
import 'package:new_ecom_project/core/services/login_api.dart';

import 'loginTab/LoginTab.dart';
import 'profileInfo/profilePage.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginStatusBloc, LoginStatusState>(
        builder: (context, state) {
      if (state is LoginStatusInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is LoginStatusSuccess) {
        return ProfileInfoPage();
      } else if (state is LogoutStatusSuccess) {
        return LoginTab(1, () {});
      }
      return Center(child: Text('Other states..'));
    });
  }
}
