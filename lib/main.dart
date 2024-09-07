import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const erox(),
    );
  }
}

class erox extends StatefulWidget {
  const erox({super.key});

  @override
  State<erox> createState() => _eroxState();
}

class _eroxState extends State<erox> {
  int num = 60;
  Timer? period;
  Duration duration = Duration(minutes: 25, seconds: 00);
  bool isRanning = false;
  @override
  Widget build(BuildContext context) {
    changetime() {
      period = Timer.periodic(Duration(milliseconds: 1), (ii) {
        setState(() {
          int newsec = duration.inSeconds - 1;
          duration = Duration(seconds: newsec);
          //int newmin = duration.inMinutes - 1;
          if (duration.inSeconds == 0) {
            ii.cancel();
            setState(() {
              duration = Duration(minutes: 25);
              isRanning = false;
            });
          }
        });
      });
    }

    void InitState() {}

    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text("Timer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircularPercentIndicator(
              
              radius: 140,
              lineWidth: 5.0,
              percent: duration.inMinutes/25,
              animateFromLastPercent: true,
              animation: true,
              progressColor: Colors.blue,
              animationDuration: 300,
              center: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    duration.inMinutes.remainder(60).toString().padLeft(2, "0"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    " : ",
                    style: TextStyle(fontSize: 80, color: Colors.white),
                  ),
                  Text(
                    duration.inSeconds.remainder(60).toString().padLeft(2, "0"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            isRanning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (period!.isActive == true) {
                              period!.cancel();
                            } else {
                              changetime();
                            }
                          });
                        },
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                          shadowColor: WidgetStatePropertyAll(Colors.red),
                          elevation: WidgetStatePropertyAll(10),
                        ),
                        child: Text(period!.isActive ? "Stop " : "resum"),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          period!.cancel();
                          setState(() {
                            duration = Duration(minutes: 25);
                            isRanning = false;
                          });
                        },
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                          shadowColor: WidgetStatePropertyAll(Colors.red),
                          elevation: WidgetStatePropertyAll(10),
                        ),
                        child: Text("cancel"),
                      )
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      changetime();
                      setState(() {
                        isRanning = true;
                      });
                    },
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                      shadowColor: WidgetStatePropertyAll(Colors.red),
                      elevation: WidgetStatePropertyAll(10),
                    ),
                    child: Text("Start timer"),
                  )
          ],
        ),
      ),
    );
  }
}
