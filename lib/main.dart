import 'package:breakpoint/widgets/title.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Break Point',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'BreakPoint',
                style: TextStyle(color: Colors.blue),
              ), // 앱바 제목
              backgroundColor: Colors.white, // 앱바 배경색
            ),
            backgroundColor: const Color(
              0xFF181818,
            ),
            body: const Column(
              children: [
                TitleWidget(title: "플레이리스트"),
              ],
            )));
  }
}
