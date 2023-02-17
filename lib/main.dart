import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BPM());

class BPM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'What is that BPM',
      home: BPMCounter(title: 'BPM'),
    );
  }
}

class BPMCounter extends StatefulWidget {
  BPMCounter({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _BPMCounter createState() => _BPMCounter();
}

class _BPMCounter extends State<BPMCounter> {
  int _n_taps = 0;
  int _m_taps = 0;
  int _bpm = 0;
  int _bpm_old_max = 0;
  int _bpm_max = 0;
  
  int _msecsFirst = 0;
  int _msecsPrevious = 0;
  int _count = 0;

  Stopwatch s = new Stopwatch();

  void _increment() {
    setState(() {
      _tap_for_bpm();
    });
  }

  void _tap_for_bpm() {
  if (!s.isRunning) {
    _count = 0;
    s.start();
   } else {
   
   }
  }

  void _tap_for_bpm_old() {
    if (!s.isRunning) {
        s.start();
    } else {
      _bpm = _n_taps ~/ (s.elapsedMicroseconds / 60000000);
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
      s.reset();
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
        backgroundColor: Colors.black,
      ),
    );
  }
}

class DrawCircle extends CustomPainter {
  Paint _paint;

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
