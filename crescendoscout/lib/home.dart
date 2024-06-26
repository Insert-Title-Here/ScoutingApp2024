import 'package:crescendoscout/adddata.dart';
import 'package:crescendoscout/viewdata.dart';
import 'package:crescendoscout/senddata.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final String comp;

  const MyHomePage(
    Key key,
    this.comp,
  ) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> removeSpecificData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> saveDataStringList(String key, List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values);
  }

  Future<List<String>?> readDataStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(),
      body: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue // Grey when not pressed
                  ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddData(),
                      ),
                    );
                  });
                },
                child: Text(
                  "Scout New Team",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue, // Grey when not pressed
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewData(),
                      ),
                    );
                  });
                },
                child: Text(
                  "View Team Data",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue, // Grey when not pressed
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendData(),
                      ),
                    );
                  });
                },
                child: Text(
                  "Send Team Data",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: Colors.blue, // Grey when not pressed
  ),
  child: TextButton(
    onPressed: () async {
      // Show confirmation dialog
      final confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text('Are you sure you want to clear all saved match data? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Confirm
              child: const Text('Clear'),
            ),
          ],
        ),
      );

      // Clear data only if confirmed
      if (confirmed ?? false) {
        List<String>? tempTeamList = await readDataStringList("teams");

        if (tempTeamList != null) {
          for (int i = 0; i < tempTeamList.length; i++) {
            removeSpecificData(tempTeamList[i]);
          }
        }

        saveDataStringList("teams", []);
      }
    },
    child: Text(
      "Clear All Data",
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
  ),
),
          ],
        ),
      ]),

      //body: ListView(),
    );
  }
}
