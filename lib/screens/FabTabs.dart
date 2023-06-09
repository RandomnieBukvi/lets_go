import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lets_go/constans.dart';
import 'package:lets_go/screens/inventory.dart';
import 'package:lets_go/screens/loading_screen.dart';
import 'package:lets_go/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:lets_go/Auth.dart';
import 'package:lets_go/screens/weapons.dart';
import 'package:lets_go/sidemenu.dart';

import '../all_weapons.dart';
import 'Register.dart';

late DataSnapshot userDataOnceOutside;

void initVariables() {
  //установка начальных значений для переменных
  double weaponActionsPositon = 0;
  weaponTxt = weapons.keys.elementAt(0);
  weaponDesc = weapons.values.elementAt(0).description;
  itemIndex = 0;
  userDataRef = FirebaseDatabase.instance
      .ref('usersData/${FirebaseAuth.instance.currentUser!.displayName}');
  isWeaponNotAquired = false;
  inventoryDataRef = userDataRef.child('inventory');
}

class Fabs extends StatelessWidget {
  Fabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("AUTH STATE CHANGES");
          if (snapshot.hasData) {
            if (snapshot.data!.displayName == null) {
              print("NO NAME");
              return FutureBuilder(
                  future: setDataOnRegister(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print("GOT NAME");
                      userDataOnceOutside = snapshot.data!;
                      initVariables();
                      return FabTabs();
                    } else {
                      return LoadingScreen();
                    }
                  });
            } else {
              return FutureBuilder(
                  future: loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      userDataOnceOutside = snapshot.data!;
                      print("HAVE NAME");
                      initVariables();
                      return FabTabs();
                    } else {
                      return LoadingScreen();
                    }
                  });
            }
          } else {
            return Auth();
          }
        });
  }
}

class FabTabs extends StatefulWidget {
  const FabTabs({super.key});

  @override
  State<FabTabs> createState() => _FabTabsState();
}

class _FabTabsState extends State<FabTabs> {
  int currentIndex = 0;
  int experience = 0;
  int cash = 0;
  late DatabaseReference userDataRef;
  late StreamSubscription<DatabaseEvent> userDataChange;
  @override
  void initState() {
    userDataRef = FirebaseDatabase.instance
        .ref()
        .child('usersData/${FirebaseAuth.instance.currentUser!.displayName}');
    currentIndex = 0;
    experience =
        int.parse(userDataOnceOutside.child('experience').value.toString());
    cash = int.parse(userDataOnceOutside.child('cash').value.toString());
    userDataChange = userDataRef.onValue.listen((event) async {
      var data = event.snapshot;
      //var data = userDataRef.child(');
      var exp = data.child('experience').value.toString();
      var c = data.child('cash').value.toString();
      if (exp != null && c != null) {
        setState(() {
          experience = int.parse(exp);
          cash = int.parse(c);
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    print("DISPOsE");
    userDataChange.cancel();
    inventoryChange.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  final List<Widget> pages = [GameMap(), Weapons(), Inventory()];

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = pages[currentIndex];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Icon(Icons.attach_money_sharp),
              Text(cash.toString()),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.star),
              Text(experience.toString()),
            ],
          )),
      drawer: SideMenu(),
      body: currentScreen,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith(
              (states) => TextStyle(color: Colors.white70)),
          backgroundColor: kPrimaryColor,
          indicatorColor: Color.fromRGBO(255, 255, 255, 0.702),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
                icon: Container(
                  child: Image.asset(
                    'assets/icons/map.png',
                    filterQuality: FilterQuality.none,
                    color: Color.fromARGB(230, 255, 255, 255),
                  ),
                ),
                selectedIcon: Container(
                  child: Image.asset(
                    'assets/icons/map.png',
                    filterQuality: FilterQuality.none,
                    color: Colors.black,
                  ),
                ),
                label: 'Map'),
            NavigationDestination(
                icon: Container(
                  child: Image.asset(
                    'assets/icons/weapons.png',
                    filterQuality: FilterQuality.none,
                    color: Color.fromARGB(230, 255, 255, 255),
                  ),
                ),
                selectedIcon: Container(
                  child: Image.asset(
                    'assets/icons/weapons.png',
                    filterQuality: FilterQuality.none,
                    color: Colors.black,
                  ),
                ),
                label: 'Weapons'),
            NavigationDestination(
                icon: Container(
                  child: Image.asset(
                    'assets/icons/inventory.png',
                    filterQuality: FilterQuality.none,
                    color: Color.fromARGB(230, 255, 255, 255),
                  ),
                ),
                selectedIcon: Container(
                  child: Image.asset(
                    'assets/icons/inventory.png',
                    filterQuality: FilterQuality.none,
                    color: Colors.black,
                  ),
                ),
                label: 'Inventory'),
          ],
        ),
      ),
    );
  }
}

Future<DataSnapshot> loadData() async {
  var data = await FirebaseDatabase.instance
      .ref('usersData/${FirebaseAuth.instance.currentUser!.displayName}')
      .get();
  await inventoryPreInit();
  return data;
}

Future<void> inventoryPreInit() async {
  DataSnapshot invGet = await FirebaseDatabase.instance
      .ref(
          'usersData/${FirebaseAuth.instance.currentUser!.displayName}/inventory')
      .get();
  book = {};
  notepad = {};
  invGet.child('book').children.forEach((element) {
    book.addAll({element.key: element.value});
  });
  Map bufer = Map();
  weapons.keys.forEach((wKey) {
    if (book[wKey] != null) {
      bufer.addAll({wKey: book[wKey]});
    }
  });
  book = bufer;

  invGet.child('notepad').children.forEach((element) {
    notepad.addAll({element.key: element.value});
  });
  bufer = {};
  weapons.keys.forEach((wKey) {
    if (notepad[wKey] != null) {
      bufer.addAll({wKey: notepad[wKey]});
    }
  });
  notepad = bufer;
  initInventory();
}
