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
        body: Component(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Component extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      child: Text("Click me"),
      onPressed: () async {
        showMenu<Object>(
          context: context,
          position: RelativeRect.fromLTRB(0, 0, 100, 100),
          items: [
            PopupMenuItem(
              child: Text("Item"),
              height: 0,
            ),
            PopupMenuItem(
              child: PopupMenuButton(
                child: Text("Click me"),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                      child: Text("Item"),
                      height: 0,
                    )
                  ];
                },
              ),
              height: 0,
            ),
          ],
        );
        // showDialog(
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: Row(
        //       children: [Icon(Icons.warning), Text(" Avast!")],
        //     ),
        //     actions: [
        //       AppButton(
        //         child: Text("Yes"),
        //         onPressed: () {},
        //       ),
        //       AppButton(
        //         child: Text("No"),
        //         onPressed: () {},
        //       )
        //     ],
        //   ),
        // );
      },
    );
  }
}
