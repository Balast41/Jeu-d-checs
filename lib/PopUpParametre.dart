import 'package:flutter/material.dart';
import 'main.dart';

double currentVolume=0;
bool isOn=true;

void showPopupParametres(BuildContext context, double currentVolume, bool isOn, Function(double) onVolumeChanged, Function(bool) onSwitchChanged) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          double _currentVolume = currentVolume;
          bool _isOn = isOn;

          return AlertDialog(
            title: const Center(
              child: Text('Paramètres', style: TextStyle(color: Colors.white)),
            ),
            backgroundColor: const Color.fromARGB(255, 158, 158, 158),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                const Text("Musique", style: TextStyle(fontSize: 20, color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.volume_off, size: 30, color: Colors.white),
                    Expanded(
                      child: Slider(
                        value: _currentVolume,
                        onChanged: (value) {
                          setState(() {
                            _currentVolume = value;
                          });
                          onVolumeChanged(value);
                        },
                        activeColor: const Color.fromARGB(255, 32, 111, 34),
                      ),
                    ),
                    const Icon(Icons.volume_up, size: 30, color: Colors.white),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Mode assisté", style: TextStyle(fontSize: 20, color: Colors.white)),
                    Switch(
                      value: _isOn,
                      onChanged: (value) {
                        setState(() {
                          _isOn = value;
                        });
                        onSwitchChanged(value);
                      },
                      activeColor: const Color.fromARGB(255, 32, 111, 34),
                    )
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fermer', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          );
        },
      );
    },
  );
  }