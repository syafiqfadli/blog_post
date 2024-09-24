import 'package:blog_post/features/volume_control/presentation/pages/volume_control_page.dart';
import 'package:blog_post/injections.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  injectionInit();
  runApp(
    MaterialApp(
      theme: ThemeData(),
      home: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const VolumeControlPage();
  }
}
