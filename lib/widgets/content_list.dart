import 'package:breakpoint/widgets/card.dart';
import 'package:flutter/material.dart';

class ContentList extends StatelessWidget {
  const ContentList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            CardWidget(text: "플레이리스트1"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
