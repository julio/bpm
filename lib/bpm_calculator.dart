import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BPMCalculator extends StatefulWidget {
  BPMCalculator({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _BPMCalculator createState() => _BPMCalculator();
}

class _BPMCalculator extends State<BPMCalculator> {
  int _n_taps = 0;
  int _m_taps = 0;
  int _bpm = 0;
  int _bpm_old_max = 0;
  int _bpm_max = 0;
  
  int _count = 0;
  List<int> _tapIntervals = [];

  Stopwatch _stopwatch = new Stopwatch();

  // TODO
  // - auto reset after 3 seconds

  void _increment() {
    setState(() {
      _tap();
    });
  }

  // void _tap_new() {
  //   final tapInterval = _stopwatch.elapsedMilliseconds;
  //   _tapIntervals.add(tapInterval);
  //   _stopwatch.reset();

  //   // Calculate the average interval between taps
  //   final averageInterval = _tapIntervals.reduce((a, b) => a + b) ~/ _tapIntervals.length;

  //   // Calculate the beats per minute
  //   _bpm = 60000 ~/ averageInterval;
  // }

  void _tap() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    } else {
      _bpm = _n_taps ~/ (_stopwatch.elapsedMicroseconds / 60000000);
    }
    if (_bpm_max < _bpm) {
      _bpm_max = _bpm;
    }
    _n_taps++;
  }

  void _reset() {
    setState(() {
      _count = 0;

      _m_taps = _n_taps;
      _n_taps = 0;
      _bpm_old_max = _bpm_max;
      _bpm = 0;
      _bpm_max = 0;
      _stopwatch.reset();
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

class DrawCircle extends CustomPainter {
  late Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color = Color.fromRGBO(92, 184, 92, 0.2)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 120.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
