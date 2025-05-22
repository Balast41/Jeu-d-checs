import 'package:flutter/material.dart';
import 'main.dart';

void showPopupParametres(BuildContext context, double currentVolume, bool isOn, Function(double) onVolumeChanged, Function(bool) onSwitchChanged) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          

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
                        value: currentVolume,
                        onChanged: (value) {
                          setState(() {
                            currentVolume = value;
                          });
                          onVolumeChanged(value); // Notifie le parent
                        },
                        min: 0.0,
                        max: 1.0,
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
                      value: isOn,
                      onChanged: (value) {
                        setState(() {
                          isOn = value;
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