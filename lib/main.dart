import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const VolumeCheck());
}

class VolumeCheck extends StatefulWidget {
  const VolumeCheck({super.key});

  @override
  State<VolumeCheck> createState() => _VolumeCheckState();
}

class _VolumeCheckState extends State<VolumeCheck> {
  static const volumeRoute = MethodChannel("samples.flutter.dev/volume");
  String volumeLevel = "null";

  Future<void> _getVolumeLevel() async {
    String volume;
    try {
      final int result = await volumeRoute.invokeMethod("getVolume");
      volume = "Volume level: $result";
    } on PlatformException catch (e) {
      volume = "Failed to get volume level: ${e.message}";
    }
    setState(() {
      volumeLevel = volume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Native Volume Level')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(volumeLevel),
              ElevatedButton(
                onPressed: _getVolumeLevel,
                child: Text('Get Volume Level'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
