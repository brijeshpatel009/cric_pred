// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widget/Divider.dart';

class ScoreDialog extends StatefulWidget {
  const ScoreDialog({Key? key, required this.teamARate, required this.teamBRate, required this.teamA, required this.teamB}) : super(key: key);
  final String teamARate;
  final String teamBRate;
  final String teamA;
  final String teamB;

  @override
  _ScoreDialogState createState() => _ScoreDialogState();
}

class _ScoreDialogState extends State<ScoreDialog> {
  @override
  void initState() {
    super.initState();
    teamRateA = int.parse(widget.teamARate);
    teamRateB = int.parse(widget.teamBRate);
    print("teamRateA: $teamRateA");
    print("teamRateB: $teamRateB");
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  late int teamRateA;
  late int teamRateB;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        contentPadding: EdgeInsets.all((width / 100) * 3),
        actionsPadding: EdgeInsets.only(bottom: (width / 100) * 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Who will win the match",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: (width / 100) * 4.6,
                ),
              ),
            ),
            const DividerWidget(color: Color(0xff2E2445), thickness: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(widget.teamA), Text(widget.teamB)],
            ),
            Container(
              width: double.infinity,
              height: 6,
              decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                children: [
                  Expanded(
                    flex: teamRateA,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.green, borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                    ),
                  ),
                  Expanded(
                    flex: teamRateB,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.red, borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
