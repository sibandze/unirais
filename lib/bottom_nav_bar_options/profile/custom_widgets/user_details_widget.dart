import 'package:flutter/material.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;
import './user_details_form_widget.dart';

class UserDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "User details",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: PRESENTATION.BACKGROUND_COLOR,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: kElevationToShadow[4],
            ),
            child: UserDetailsForm(),
          ),
        ],
      ),
    );
  }
}
