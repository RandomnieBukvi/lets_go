import 'package:flutter/material.dart';
import 'package:lets_go/screens/FabTabs.dart';
import 'package:lets_go/shared_prefs.dart';
import 'package:lets_go/constans.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

//bool isSigned = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyBopLmS7xqMMu113JR3iOH5rViqEVTj8qA',
        appId: '1:929569094769:android:e22414ebb665d548d6efd0',
        messagingSenderId: '929569094769',
        projectId: 'tensaiproject-2e8cc'),
  );
  //final SharedPreferences prefs = await SharedPreferences.getInstance();

  /*if (prefs.containsKey('isSigned') == false) {
    prefs.setBool('isSigned', false);
  }*/

  //isSigned = prefs.getBool('isSigned')!;

  print("started");
  SharedPrefs().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: kPrimaryColor,
            onPrimary: kTextWhiteColor,
            secondary: kSecondaryColor,
            onSecondary: kTextBlackColor,
            error: kErrorBorderColor,
            onError: kTextWhiteColor,
            background: Colors.white,
            onBackground: kTextBlackColor,
            surface: kTextLightColor,
            onSurface: kTextBlackColor),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Fabs(),
        /*'/register': (context) => Register(),
        '/login': (context) => Login(),*/
      },
    );
  }
}
