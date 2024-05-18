import 'package:flutter/material.dart';

class NasaApodApp extends StatelessWidget {
  const NasaApodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("NASA - Astronomy Picture of the Day"),
        ),
      ),
    );
  }
}
