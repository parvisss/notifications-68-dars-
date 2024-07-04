import 'package:flutter/material.dart';
import 'package:frp/services/local_notificatuon_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificatuonService.requistPermission();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(LocalNotificatuonService.notificationEnabled
                  ? "Xabarnoma yoniq"
                  : "xabarnoma ruxsat berilmagan"),
              FilledButton(
                  onPressed: () {
                    LocalNotificatuonService.showNotification();
                  },
                  child: Text("Darxol"))
            ],
          ),
        ),
      ),
    );
  }
}
