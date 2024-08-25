import 'package:breakpoint/widgets/add_song.dart';
import 'package:breakpoint/widgets/content_list.dart';
import 'package:breakpoint/widgets/title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(
          0xFF181818,
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF181818),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddSong()),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // HeaderWidget(),
              TitleWidget(title: "플레이리스트"),
              ContentList(),
              TitleWidget(title: "최근에 들은 곡"),
              ContentList(),
              TitleWidget(title: "플레이리스트"),
              ContentList(),
            ],
          ),
        ));
  }
}
