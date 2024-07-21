import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wordhurdle/hurdle_provider.dart';
import 'package:wordhurdle/word_hurdle_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => HurdleProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,
        brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const WordHurdlePage(),
      builder: EasyLoading.init(),
    );
  }
}
