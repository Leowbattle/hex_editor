import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_menu.dart';

void main() {
  runApp(HexEditorApp());
}

class HexEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Colors.white,
      textStyle: TextStyle(color: Colors.black),
      builder: (BuildContext bc, __) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppMenu(
                items: [
                  AppMenuItem(
                      label: AppButton(
                    child: Text("File"),
                    onPressed: () {},
                  )),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      for (int i = 0; i < 10; i++)
                        MaterialButton(
                          child: Text("Button $i"),
                          onPressed: () {
                            print("Button $i was pressed");
                          },
                          elevation: 0,
                          hoverElevation: 0,
                          highlightElevation: 0,
                          splashColor: Colors.transparent,
                          color: Color(0xffe0e0e0),
                        )
                      // AppButton(
                      //   child: Text("Button $i"),
                      //   onPressed: () {
                      //     print("Button $i was pressed");
                      //   },
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
