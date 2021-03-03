import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mh_weapon_omikuji/helper/shared_preferences_helper.dart';

import 'constans.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String title = 'MH Weapon Omikuji';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentWeapon = initialWeaponLabel;
  List<String> currentWeapons = [];

  @override
  void initState() {
    super.initState();
    _getCurrentWeapons();
  }

  _getCurrentWeapons() async {
    String weapon =
        await SharedPreferencesHelper.getCurrentWeapon() ?? initialWeaponLabel;
    List<String> list = await SharedPreferencesHelper.getList() ?? weapons;

    setState(() {
      currentWeapon = weapon;
      currentWeapons.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() async {
                currentWeapon = initialWeaponLabel;
                await SharedPreferencesHelper.setCurrentWeapon(currentWeapon);

                currentWeapons
                  ..clear()
                  ..addAll(weapons);
                await SharedPreferencesHelper.clearAll();
                await SharedPreferencesHelper.setList(weapons);
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _decideWeapon,
            child: AspectRatio(
              aspectRatio: 10 / 2,
              child: Center(
                child: Text(
                  currentWeapon,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Kosugi',
                  ),
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.blue,
            ),
          ),
          Text(
            '$currentWeapons',
            style: TextStyle(fontFamily: 'Kosugi'),
          ),
        ],
      ),
    );
  }

  Future<void> _decideWeapon() async {
    int index = Random().nextInt(currentWeapons.length);
    setState(() {
      currentWeapon = currentWeapons[index];
      currentWeapons.removeAt(index);
    });

    if (currentWeapons.isEmpty) {
      currentWeapons.addAll(weapons);
    }

    await SharedPreferencesHelper.setCurrentWeapon(currentWeapon);
    await SharedPreferencesHelper.setList(currentWeapons);
  }
}
