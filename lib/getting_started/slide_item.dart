import 'package:flutter/material.dart';

import './../model/_model.dart';
import './../presentation/_presentation.dart' as PRESENTATION;

class SlideItem extends StatelessWidget {
  final index;

  const SlideItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var slideItem = slideList[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(slideItem.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 36,
        ),
        Text(
          slideItem.title,
          style: PRESENTATION.SLIDE_HEADING_TEXT_STYLE,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          slideItem.description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
