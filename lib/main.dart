import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hex_editor/app_button.dart';

void main() {
  runApp(HexEditorApp());
}

class HexEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(),
      home: Scaffold(
        body: HexEditor(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HexEditor extends StatefulWidget {
  @override
  _HexEditorState createState() => _HexEditorState();
}

class _HexEditorState extends State<HexEditor> {
  ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      thickness: 20,
      radius: Radius.zero,
      child: ListView.builder(
        itemBuilder: (_, i) {
          return Text(
            (i * 16).toRadixString(16).toUpperCase().padLeft(8, '0'),
            style: TextStyle(fontFamily: "Consolas"),
          );
        },
        padding: EdgeInsets.all(5),
        itemCount: 1000,
      ),
    );
    // return Scrollbar(
    //   isAlwaysShown: true,
    //   thickness: 20,
    //   radius: Radius.zero,
    //   child: ListView(
    //     children: [
    //       for (int i = 0; i < 100; i++)
    //         Row(
    //           children: [
    //             Text(
    //               (i * 16).toRadixString(16).padLeft(8, '0'),
    //               style: TextStyle(fontFeatures: [
    //                 FontFeature.tabularFigures(),
    //                 FontFeature.slashedZero()
    //               ]),
    //             ),
    //           ],
    //         )
    //     ],
    //   ),
    // );
  }
}
