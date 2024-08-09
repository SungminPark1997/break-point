import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.white, // 경계선의 색상
          thickness: 2, // 경계선의 두께
        ),
        Row(
          children: [
            const SizedBox(
              width: 30, // 텍스트 왼쪽의 공백
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
          ],
        ),
        const SizedBox(height: 5), // 텍스트와 경계선 사이의 간격
        const Divider(
          color: Colors.white, // 경계선의 색상
          thickness: 2, // 경계선의 두께
        ),
      ],
    );
  }
}
