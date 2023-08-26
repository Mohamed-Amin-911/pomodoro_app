import 'package:flutter/material.dart';
import "dart:async";
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer? repeatedFunc;
  Duration duration = const Duration(minutes: 25);
  bool isRunning = true;
  startTimer() {
    repeatedFunc = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int sec = duration.inSeconds - 1;
        duration = Duration(seconds: sec);
        if (duration.inSeconds == 0) {
          repeatedFunc!.cancel();
          setState(() {
            duration = const Duration(minutes: 25);
            isRunning = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 35, 93),
        title: Text(
          "POMODORO",
          style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    progressColor: const Color.fromARGB(255, 34, 35, 93),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    lineWidth: 12,
                    percent: duration.inSeconds / 1500,
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 1000,
                    radius: 120.0,
                    center: Text(
                      "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                      style: const TextStyle(
                          fontSize: 45,
                          color: Color.fromARGB(255, 34, 35, 93),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            isRunning
                ? ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRunning = false;
                      });
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 4)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 34, 35, 93))),
                    child: Text(
                      "start",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (repeatedFunc!.isActive) {
                            setState(() {
                              repeatedFunc!.cancel();
                            });
                          } else {
                            startTimer();
                          }
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 4)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 34, 35, 93))),
                        child: Text(
                          (repeatedFunc!.isActive) ? "Stop" : "Resume",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          repeatedFunc!.cancel();
                          setState(() {
                            duration = const Duration(minutes: 25);
                            isRunning = true;
                          });
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 4)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 34, 35, 93))),
                        child: Text(
                          "cancel",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
