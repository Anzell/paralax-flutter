import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ParallaxScreen(),
    );
  }
}

class ParallaxScreen extends StatefulWidget {
  const ParallaxScreen({Key? key}) : super(key: key);

  @override
  State<ParallaxScreen> createState() => _ParallaxScreenState();
}

class _ParallaxScreenState extends State<ParallaxScreen> {
  double padX = 0.0;
  double padY = 0.0;

  @override
  void initState() {
    super.initState();
    _initAccelerometerController();
  }

  void _initAccelerometerController() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        if (event.x > 0) {
          padX = _accelerator(event.x.abs());
        } else {
          padX = -_accelerator(event.x.abs());
        }
        if (event.y > 0) {
          padY = _accelerator(event.y.abs());
        } else {
          padY = -_accelerator(event.y.abs());
        }
      });
    });
  }

  double _accelerator(double position) {
    return position * 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Positioned(
              top: -padY,
              bottom: padY,
              right: -padX,
              left: padX,
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    width: constraints.maxWidth / 2.1,
                    height: constraints.maxHeight / 3.1,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 1)],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://m.media-amazon.com/images/I/61JTQ28AzoL._AC_SX466_.jpg",
                          )),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: constraints.maxWidth / 2,
                height: constraints.maxHeight / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://m.media-amazon.com/images/I/61JTQ28AzoL._AC_SX466_.jpg",
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
