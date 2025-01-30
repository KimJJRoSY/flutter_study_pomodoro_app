import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;

  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
  }

// 사용자가 버튼을 누를때만 타이머 생성
  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      // 타이머는 매 초마다 onTick 함수 실행
      onTick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //main에서 정했던 theme에서 배경색 가져옴
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // flexible의 역할은 하드 코딩되는 값을 만들게 해줌
          //=> UI를 비율에 기반해서 더 유연하게 만들 수 있게함
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                '$totalSeconds',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            // flex 숫자 크기에 따라 보여지는 화면 비율 달라짐 -> 반응형으로 만들때 용이
            flex: 3,
            child: Center(
              child: IconButton(
                onPressed: onStartPressed,
                icon: Icon(Icons.play_circle_outline),
                iconSize: 98,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      // 주 방향은 수직 방향
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
