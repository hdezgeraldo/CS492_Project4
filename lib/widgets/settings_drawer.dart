// import 'package:flutter/material.dart';
// import 'dark_switch.dart';
//
// class SettingsDrawer extends StatelessWidget {
//   const SettingsDrawer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       // Add a ListView to the drawer. This ensures the user can scroll
//       // through the options in the drawer if there isn't enough vertical
//       // space to fit everything.
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.all(0),
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text('Settings'),
//           ),
//           Container(
//             child: DarkThemeSwitch()
//           )
//           // SettingsDrawer(),
//         ],
//       ),
//     );
//   }
// }