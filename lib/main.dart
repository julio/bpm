import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bpm_calculator.dart';

void main() => runApp(BPM());

class BPM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'What is that BPM',
      home: BPMCalculator(title: 'BPM'),
    );
  }
}