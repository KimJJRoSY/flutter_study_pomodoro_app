import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // flexible의 역할은 하드 코딩되는 값을 만들게 해줌
          //=> UI를 비율에 기반해서 더 유연하게 만들 수 있게함
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
          ),
          Flexible(
            // flex 숫자 크기에 따라 보여지는 화면 비율 달라짐 -> 반응형으로 만들때 용이
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
