import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:invest_propensity_test_demo/propensity_demo.dart';
import 'package:invest_propensity_test_demo/propensity_demo2.dart';
import 'package:invest_propensity_test_demo/propensity_demo3.dart';
import 'package:invest_propensity_test_demo/propensity_demo6.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.grey[400],
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const MyHomePage(title: '투자성향 테스트 데모'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: const Text(
          'Hello World',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.navigate_next),
            backgroundColor: Colors.blue,
            label: 'Second Page',
            shape: CircleBorder(),
            labelBackgroundColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormPage()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.navigate_next),
            shape: CircleBorder(),
            backgroundColor: Colors.green,
            label: 'Third Page',
            labelBackgroundColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.navigate_next),
            backgroundColor: Colors.red,
            shape: CircleBorder(),
            label: 'Fourth Page',
            labelBackgroundColor: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IconStepperDemo()),
              );
            },
          ),
          // SpeedDialChild(
          //   child: const Icon(Icons.navigate_next),
          //   backgroundColor: Colors.yellow,
          //   shape: CircleBorder(),
          //   label: 'Fifth Page',
          //   labelBackgroundColor: Colors.yellow,
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => FifthPage()),
          //     );
          //   },
          // ),
          // SpeedDialChild(
          //   child: const Icon(Icons.navigate_next),
          //   backgroundColor: Colors.orange,
          //   shape: CircleBorder(),
          //   label: 'Sixth Page',
          //   labelBackgroundColor: Colors.orange,
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => SixthPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Second Page', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: const Text('This is the Second Page',
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Third Page', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: const Text('This is the Third Page',
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Fourth Page', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: const Text('This is the Fourth Page',
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
