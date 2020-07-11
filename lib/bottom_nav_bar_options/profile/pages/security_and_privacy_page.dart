import 'package:flutter/material.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;

const _PAGE_TITLE = "Security and privacy";

class SecurityAndPrivacyPage extends StatefulWidget {
  @override
  _SecurityAndPrivacyPageState createState() => _SecurityAndPrivacyPageState();
}

class _SecurityAndPrivacyPageState extends State<SecurityAndPrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _CustomAppBar(),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        top: 12,
        bottom: 12,
      ),
      color: PRESENTATION.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Icon(
              PRESENTATION.Font_awesome_icons.menu,
            ),
            onTap: () async {
              Scaffold.of(context).openDrawer();
            },
          ),
          SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _PAGE_TITLE,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
