import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  AppMenu({required this.items});

  final List<AppMenuItem> items;

  @override
  _AppMenuState createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffe0e0e0),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          for (var item in widget.items)
            Padding(
              padding: EdgeInsets.all(5),
              child: item,
            )
        ],
      ),
    );
  }
}

class AppMenuItem extends StatelessWidget {
  AppMenuItem({required this.label});

  final Widget label;

  @override
  Widget build(BuildContext context) {
    return label;
  }
}
