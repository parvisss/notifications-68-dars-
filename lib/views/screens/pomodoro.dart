import 'package:flutter/material.dart';
import 'package:frp/services/notification_for_pomodoro.dart';
import 'package:gap/gap.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {
              NotificationForPomodoro().restart();
            },
            child: const Text("start"),
          ),
          const Gap(20),
          FilledButton(
            onPressed: () {
              NotificationForPomodoro().cancel();
            },
            child: const Text("stop"),
          ),
        ],
      ),
    );
  }
}
