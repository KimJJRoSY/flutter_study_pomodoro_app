import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      //totalSeconds가 0 이면 타이머 중지되었을때 속성 초기화
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

// 사용자가 버튼을 누를때만 타이머 생성
  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      // 타이머는 매 초마다 onTick 함수 실행
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onReset() {
    setState(() {
      totalPomodoros = totalPomodoros + 1;
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
    });
    timer.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    // string으로 타입 변경  -> 0:25:00.000000
    // print(duration.toString());
    // .을 기준으로 문자열 분리 후, 리스트로 반환 ->[0:25:00, 000000]
    // print(duration.toString().split('.'));
    // 리스트에서 첫 번째 인덱스 선택 후 , 필요한 부분 슬라이싱 => 25:00
    // print(duration.toString().split('.').first.substring(2, 7));
    return duration.toString().split('.').first.substring(2, 7);
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
                format(totalSeconds),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  // isrunning이 true면 오른쪽 항
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                  iconSize: 98,
                  color: Theme.of(context).cardColor,
                ),
                TextButton(
                    onPressed: onReset,
                    child: Text(
                      'reset',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 20,
                      ),
                    ))
              ],
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
                          '$totalPomodoros  ',
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
