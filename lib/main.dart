import 'package:app_diario/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'core/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await deleteDb();
  await AppDataBase.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Humor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,

      // home: const ImagePickerWidget(),
    );
  }
}
