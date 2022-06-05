import 'package:bwc_test/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

GlobalKey<NavigatorState> navigatorState = GlobalKey();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerState = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorState,
        scaffoldMessengerKey: scaffoldMessengerState,
        debugShowCheckedModeBanner: false,
        home: const MainPage());
  }
}
