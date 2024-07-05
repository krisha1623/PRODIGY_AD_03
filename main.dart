import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  //running app

  //bussiness logic of app
  int seconds = 0, minutes = 0, hours = 0, miliseconds = 0;
  String digitSeconds = "00",
      digitMinutes = "00",
      digitHours = "00",
      digitmiliseconds = "000";
  Timer? timer;
  bool started = false;
  List<String> laps = [];

  //stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //reset function
  void reset() {
    timer!.cancel();
    setState(() {
      miliseconds = 0;
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitmiliseconds = "000";
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
      laps.clear();
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds:$digitmiliseconds";
    setState(() {
      laps.add(lap);
    });
  }

  //start timer function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      int localMiliseconds = miliseconds + 1;
      int localSeconds = seconds;
      int localMinutes = minutes;
      int localHours = hours;

      if (localMiliseconds > 59) {
      
          if (localMinutes > 59) {
            localHours++;
            localMinutes = 0;
          } else if (localSeconds > 59){
            localMinutes++;
            localSeconds = 0;
          }else{
            localSeconds++;
            localMiliseconds = 0;
          
        }
      }
      setState(() {
        miliseconds = localMiliseconds;
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitmiliseconds = (miliseconds >= 10) ? "$miliseconds" : "0$miliseconds";
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "StopWatch App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "$digitHours : $digitMinutes : $digitSeconds: $digitmiliseconds",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 62,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Color(0xFF323F68),
                borderRadius: BorderRadius.circular(8),
              ),
              //adding list builder
              child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n${index + 1}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started) ? "Start" : "Pause",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    addLaps();
                  },
                  icon: Icon(Icons.flag),
                ),
                Expanded(
                    child: RawMaterialButton(
                  onPressed: () {
                    reset();
                  },
                  fillColor: Colors.blue,
                  shape: const StadiumBorder(),
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
