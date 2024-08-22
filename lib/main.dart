import 'package:corelabo_app_challenge/database/db.dart';
import 'package:flutter/material.dart';
import 'package:corelabo_app_challenge/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();
  await dbHelper.database;

  runApp(const App());
}
