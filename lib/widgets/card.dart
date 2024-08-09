import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  //final String imageUrl;
  final String text;

  const CardWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 사각형 컨테이너 안에 이미지
        Container(
          width: 150, // 사각형의 너비
          height: 200, // 사각형의 높이
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white), // 사각형의 테두리 색상
          ),
          /*child: Image.network(
            imageUrl,
            fit: BoxFit.cover, // 이미지를 사각형 안에 맞춤
          ),*/
        ),
        const SizedBox(height: 10), // 이미지와 텍스트 사이의 간격
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ), // 텍스트 스타일
        ),
      ],
    );
  }
}
