import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BPMCalculator _bpmCalculator = BPMCalculator();

  double _currentBPM = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the BPM calculator
    _bpmCalculator.start();
    _bpmCalculator.onBPMChange = (bpm) {
      setState(() {
        _currentBPM = bpm;
      });
    };
  }

  @override
  void dispose() {
    // Stop the BPM calculator when the app is closed
    _bpmCalculator.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BPM Calculator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current BPM:',
              ),
              Text(
                _currentBPM.toStringAsFixed(2),
                style: TextStyle(fontSize: 32.0),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _bpmCalculator.tap();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class BPMCalculator {
  List<int> _tapIntervals = [];
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Function(double)? onBPMChange;

  void start() {
    _stopwatch.start();
  }

  void stop() {
    _stopwatch.stop();
    _tapIntervals.clear();
  }

  void tap() {
    final tapInterval = _stopwatch.elapsedMilliseconds;
    _tapIntervals.add(tapInterval);
    _stopwatch.reset();

    // Calculate the average interval between taps
    final averageInterval = _tapIntervals.reduce((a, b) => a + b) ~/ _tapIntervals.length;

    // Calculate the beats per minute
    final bpm = 60000 / averageInterval;

    // Trigger the onBPMChange callback with the updated BPM value
    if (onBPMChange != null) {
      onBPMChange!(bpm);
    }
  }
}
