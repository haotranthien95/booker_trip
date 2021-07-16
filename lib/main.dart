// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/getUserTripBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/event/GetUserTripEvent.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/GetUserTripState.dart';
import 'package:new_ecom_project/ui/modules/home/page/MainPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/services.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchPage.dart';
import 'package:new_ecom_project/ui/modules/searchPage/searchPageProvider.dart';
import 'package:new_ecom_project/ui/modules/tripCreatePage/tripCreatePage.dart';
import 'package:new_ecom_project/ui/modules/userPage/userMainPage.dart';
import 'package:provider/provider.dart';
import 'core/blocs/getTripsBloc.dart';
import 'core/flutter_bloc/bloc/getDetailTripBloc.dart';
import 'core/flutter_bloc/bloc/getHotTripBloc.dart';
import 'core/flutter_bloc/bloc/loginBloc.dart';
import 'core/flutter_bloc/event/GetHotTripEvent.dart';
import 'core/flutter_bloc/event/LoginStatusEvent.dart';
import 'ui/modules/tripCreatePage/locationPageNewTrip/locationPageNewTrip.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SearchPageProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoStoreApp();
  }
}

class CupertinoStoreApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool buildA = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // FirebaseAnalytics analytics = FirebaseAnalytics();
    WidgetsFlutterBinding.ensureInitialized();
    FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
    return CupertinoApp(
        theme: CupertinoThemeData(
          primaryColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('fr', ''),
          const Locale('vi', ''),
        ],
        home: MultiBlocProvider(providers: [
          BlocProvider(create: (BuildContext context) => GetUserTripBloc()),
          BlocProvider(create: (BuildContext context) => GetHotTripBloc()),
          BlocProvider(create: (BuildContext context) => GetDetailTripBloc()),
          BlocProvider(
              create: (BuildContext context) =>
                  LoginStatusBloc()..add(GetLoginEvent()))
        ], child: MainPage())); //MainPage
    //home: TripCreatePage());
  }
  //   return FutureBuilder(
  //       future: _initialization,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           print("Build 1");

  //           return MaterialApp(
  //             home: Scaffold(
  //               body: Text(snapshot.error.toString()),
  //             ),
  //           );
  //         }

  //         // Once complete, show your application
  //         else if (snapshot.connectionState == ConnectionState.done ||
  //             buildA == true) {
  //           print("Build 2");
  //           buildA = true;
  //           return CupertinoApp(
  //               theme: CupertinoThemeData(
  //                 primaryColor: Colors.orange,
  //                 brightness: Brightness.dark,
  //               ),
  //               localizationsDelegates: [
  //                 AppLocalizations.delegate,
  //                 GlobalMaterialLocalizations.delegate,
  //                 GlobalWidgetsLocalizations.delegate,
  //                 GlobalCupertinoLocalizations.delegate,
  //               ],
  //               supportedLocales: [
  //                 const Locale('en', ''),
  //                 const Locale('fr', ''),
  //                 const Locale('vi', ''),
  //               ],
  //               home: MainPage()); //MainPage
  //           //home: TripCreatePage());

  //         }

  //         // Otherwise, show something whilst waiting for initialization to complete
  //         // else {
  //         //   print("Build 3");

  //         //   return MaterialApp(
  //         //     home: Scaffold(
  //         //       body: Text("Please wait"),
  //         //     ),
  //         //   );
  //         // }
  //       });
  // }
}
