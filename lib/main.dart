import 'package:flutter/material.dart';
import 'package:stream_controller/screens/usd_screen.dart';
import 'package:stream_controller/screens/eur_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Stream Controller',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: MenuScreen(),
      routes: {
        '/USD': (context) => UsdScreen(),
        '/EUR': (context) => EurScreen(),
      },
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/USD');
              },
              child: Text('💶 USD to COP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/EUR');
              },
              child: Text('💶 EUR to COP'),
            ),
          ],
        ),
      ),
    );
  }
}
