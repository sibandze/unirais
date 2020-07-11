import 'package:flutter/material.dart';

import './../presentation/_presentation.dart' as PRESENTATION;

class SlideDot extends StatefulWidget {
  final bool isActive;

  SlideDot({
    isActive,
  }) : isActive = (isActive == null) ? false : isActive;

  @override
  _SlideDotState createState() => _SlideDotState();
}

class _SlideDotState extends State<SlideDot> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: widget.isActive ? 12 : 8,
      width: widget.isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: widget.isActive
            ? PRESENTATION.PRIMARY_COLOR
            : PRESENTATION.TEXT_LIGHT_COLOR,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
