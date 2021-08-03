// import 'package:flutter/material.dart';
// import '../screens/new_entry.dart';
// import '../screens/journal_entries.dart';
// import '../widgets/settings_drawer.dart';
//
// class Welcome extends StatelessWidget {
//   static const routeName = '/';
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome'),
//         actions: [
//           Builder(
//             builder: (context) => IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () => Scaffold.of(context).openEndDrawer(),
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: JournalEntriesScreen()
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed(NewEntry.routeName);
//         },
//         child: Icon(Icons.add)
//       ),
//       endDrawer: SettingsDrawer(),
//       endDrawerEnableOpenDragGesture: false,
//     );
//   }
// }
