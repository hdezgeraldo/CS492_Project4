import 'package:flutter/material.dart';
import 'dark_switch.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Settings'),
          ),
          Container(
              child: DarkThemeSwitch()
          )
          // SettingsDrawer(),
        ],
      ),
    );
  }
}