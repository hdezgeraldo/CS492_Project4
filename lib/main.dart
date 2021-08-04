import 'package:flutter/material.dart';
import 'app.dart';
import 'db/database_manager.dart';

const String title = 'Week 5 Explorations';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.initialize();
  runApp(App());
}
