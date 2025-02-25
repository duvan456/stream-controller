import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EurScreen extends StatefulWidget {
  const EurScreen({super.key});

  @override
  State<EurScreen> createState() => _EurScreenState();
}

class _EurScreenState extends State<EurScreen> {
  final StreamController<List<Map<String, dynamic>>> _streamController = StreamController<List<Map<String, dynamic>>>();
  double _rmr = 4277.20;
  final Random _random = Random();
  final List<Map<String, dynamic>> _rmrList = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      double change = (_random.nextInt(100)-50)/100;
      change = double.parse(change.toStringAsFixed(2));
      _rmr += change;
      final now = DateTime.now();
      _rmrList.add({
        'value': _rmr,
        'timestamp': now,
      });
      _streamController.add(List.from(_rmrList));
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💶 EUR to COP'),
      ),
      body: Center(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                    final value = '\$' + item['value'].toStringAsFixed(2);
                  final timestamp = item['timestamp'] as DateTime;
                  return ListTile(
                    title: Text('RMR: $value'),
                    subtitle: Text('Fecha: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp).toString()}'),
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
