import 'package:flutter/material.dart';
import 'package:frp/models/controllers/motivation_controller.dart';
import 'package:frp/services/notification_for_motivation.dart';
import 'package:gap/gap.dart';

class Motivation extends StatefulWidget {
  Motivation({super.key});

  @override
  State<Motivation> createState() => _MotivationState();
}

class _MotivationState extends State<Motivation> {
  final MotivationController _motivationController = MotivationController();
  @override
  void initState() {
    NotificationForMotivation().repeatPomodoroReminder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder<List>(
        future: _motivationController.fetchMotivation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      snapshot.data![0],
                      style: const TextStyle(fontSize: 20),
                    ),
                    contentPadding: const EdgeInsets.all(30),
                    subtitle: Text(
                      snapshot.data![1],
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
