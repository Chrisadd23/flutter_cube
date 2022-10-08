import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset _offset = Offset.zero;
  double _rx = 0.0, _ry = 0.0, _rz = 0.0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
      onPanUpdate: (details) {
        _rx += details.delta.dx;
        _ry += details.delta.dy;
        setState(() {
          _rx %= pi * 2;
          _ry %= pi * 2;
          _rz %= pi * 2;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(_rx * pi / 180)
                    ..rotateY(_ry * pi / 180)
                    ..rotateZ(_rz * pi / 180),
                  alignment: Alignment.center,
                  child: const Center(child: Cube())),
              const SizedBox(height: 32),
              Slider(
                value: _ry,
                min: 0,
                max: 360,
                onChanged: (double value) => setState(() {
                  _ry = value;
                }),
              ),
              Slider(
                value: _rx,
                min: 0,
                max: 360,
                onChanged: (double value) => setState(() {
                  _rx = value;
                }),
              ),
              Slider(
                value: _rz,
                min: 0,
                max: 360,
                onChanged: (double value) => setState(() {
                  _rz = value;
                }),
              )
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class Cube extends StatelessWidget {
  const Cube({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      Transform(
        transform: Matrix4.identity()..translate(0.0, 0.0, 100.0),
        child: Container(
          color: Colors.red,
          width: 200,
          height: 200,
        ),
      ),
      Transform(
        //startboard
        transform: Matrix4.identity()
          ..rotateY(-pi / 2)
          ..translate(-100.0, 0.0, 0.0),
        child: Container(
          color: Colors.orange,
          width: 200,
          height: 200,
        ),
      ),
      Transform(
        transform: Matrix4.identity()
          ..rotateX(pi / 2)
          ..translate(0.0, -100.0, 0.0),
        child: Container(
          color: Colors.blue,
          width: 200,
          height: 200,
        ),
      ),
    ]);
  }
}
