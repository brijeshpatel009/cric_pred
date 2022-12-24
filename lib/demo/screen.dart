import 'dart:async';

import 'package:flutter/material.dart';
import 'tabs_widget.dart';


class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final StreamController<int> tabChangeNotifier = StreamController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Change Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tab Change Demo'),
        ),
        body: SingleChildScrollView(child: Column(
          children: [
            const SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(onPressed: () => tabChangeNotifier.add(0), child: const Text('Go Orange')),
              ElevatedButton(onPressed: () => tabChangeNotifier.add(1), child: const Text('Go Red')),
              ElevatedButton(onPressed: () => tabChangeNotifier.add(2), child: const Text('Go Green')),
            ],),
            const SizedBox(height: 30,),
            // TabsWidget(changeReceiver: tabChangeNotifier.stream, tabs: const [
            //   Tab(icon: Icon(Icons.circle, color: Colors.orange,),),
            //   Tab(icon: Icon(Icons.circle, color: Colors.red,),),
            //   Tab(icon: Icon(Icons.circle, color: Colors.green,),),
            // ],
        // ),
          ],
        ),), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  @override
  void dispose() {
    tabChangeNotifier.close();
    super.dispose();
  }
}