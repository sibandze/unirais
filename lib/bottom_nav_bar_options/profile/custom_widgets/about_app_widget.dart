import 'package:flutter/material.dart';

import './../../../const/_const.dart' as CONSTANTS;

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      icon: Icon(Icons.info),
      applicationIcon: _logo,
      applicationName: CONSTANTS.APP_NAME,
      applicationVersion: CONSTANTS.APP_VERSION,
      applicationLegalese: CONSTANTS.APP_LEGALESE,
      aboutBoxChildren: _aboutBoxChildren(context),
    );
  }

  Widget get _logo => Image.asset(
        CONSTANTS.APP_LOGO,
        fit: BoxFit.fitHeight,
        height: 72,
        width: 72,
      );

  List<Widget> _aboutBoxChildren(context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;
    return <Widget>[
      SizedBox(height: 24),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              style: textStyle,
              text: CONSTANTS.ABOUT_APP,
            ),
            TextSpan(
              style: textStyle.copyWith(color: Theme.of(context).accentColor),
              text: CONSTANTS.WEBSITE,
            ),
            TextSpan(
              style: textStyle,
              text: '.',
            ),
          ],
        ),
      ),
    ];
  }
}
