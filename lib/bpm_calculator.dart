import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'draw_circle.dart';

class BPMCalculator extends StatefulWidget {
  BPMCalculator({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _BPMCalculator createState() => _BPMCalculator();
}

class _BPMCalculator extends State<BPMCalculator> {
  int _n_taps = 0;
  int _bpm = 0;
  
  Stopwatch _stopwatch = new Stopwatch();

  void _increment() {
    setState(() {
      _tap();
    });
  }

  void _tap() {
    _stopwatch.start();
      double seconds = _stopwatch.elapsedMicroseconds / 60000000;
      _bpm = _n_taps ~/ seconds;
      // print('seconds = $seconds | bpm = $_bpm | _n_taps = $_n_taps');
    _n_taps++;
  }

  void _reset() {
    setState(() {
      _n_taps = 0;
      _bpm = 0;
      _stopwatch.reset();
      _stopwatch.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text('BPM'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text(
                        '$_bpm',
                        style: TextStyle(color: Colors.white, fontSize: 90),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          RawMaterialButton(
            onPressed: _increment,
            splashColor: Colors.purple,
            child: Container(
              child: CustomPaint(painter: DrawCircle()),
            ),
            shape: new CircleBorder(),
            elevation: 5.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(135.0),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reset,
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
