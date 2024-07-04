import 'package:flutter/material.dart';
import 'package:frp/services/local_notificatuon_service.dart';
import 'package:frp/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificatuonService.requistPermission();
  await LocalNotificatuonService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
