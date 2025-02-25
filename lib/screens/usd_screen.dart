import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class UsdScreen extends StatefulWidget {
  const UsdScreen({super.key});

  @override
  State<UsdScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<UsdScreen> {
  final StreamController<List<Map<String, dynamic>>> _counterController = StreamController<List<Map<String, dynamic>>>();
  double _counter = 4088.11;
  final Random _random = Random();
  final List<Map<String, dynamic>> _counterList = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      double change = ((_random.nextInt(35) + 1) - 35) / 100.0;
      change = double.parse(change.toStringAsFixed(2));
      _counter += change;
      final now = DateTime.now();
      _counterList.add({
        'value': _counter,
        'timestamp': now,
      });
      _counterController.add(List.from(_counterList));
    });
  }

  @override
  void dispose() {
    _counterController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💶 USD to COP'),
      ),
      body: Center(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _counterController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  final value = item['value'].toStringAsFixed(2);
                  final timestamp = item['timestamp'] as DateTime;
                  return ListTile(
                    title: Text('Tasa de cambio: $value'),
                    subtitle: Text('Fecha: ${timestamp.toString()}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
