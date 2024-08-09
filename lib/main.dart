import 'package:breakpoint/widgets/content_list.dart';
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
        home: const Scaffold(
            backgroundColor: Color(
              0xFF181818,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TitleWidget(title: "플레이리스트"),
                  ContentList(),
                  TitleWidget(title: "최근에 들은 곡"),
                  ContentList(),
                  TitleWidget(title: "플레이리스트"),
                  ContentList(),
                ],
              ),
            )));
  }
}
