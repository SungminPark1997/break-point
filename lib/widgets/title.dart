import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
              const SizedBox(height: 5), // 텍스트와 경계선 사이의 간격
              const Divider(
                color: Colors.white, // 경계선의 색상
                thickness: 2, // 경계선의 두께
              ),
            ],
          ),
        )
      ],
    );
  }
}
