import 'package:flutter/material.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;

class UserDetailsForm extends StatefulWidget {
  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          SizedBox(height: 4),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            controller: _firstNameController,
            style: TextStyle(
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.text,
            cursorColor: PRESENTATION.PRIMARY_COLOR,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              fillColor: Colors.white,
              hintText: 'First name(s)',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: PRESENTATION.PRIMARY_COLOR,
                  width: 2.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.next,
            //onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            controller: _lastNameController,
            style: TextStyle(
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.text,
            cursorColor: PRESENTATION.PRIMARY_COLOR,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              fillColor: Colors.white,
              hintText: 'Last name',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: PRESENTATION.PRIMARY_COLOR,
                  width: 2.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
              ),
              child: RaisedButton(
                elevation: 1.0,
                onPressed: () async {},
                child: Text(
                  'UPDATE',
                  style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(15),
                color: PRESENTATION.PRIMARY_COLOR,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _firstNameController = new TextEditingController(
      text: 'Nkosingiphile',
    );
    _lastNameController = new TextEditingController(
      text: 'Sibandze',
    );
    super.initState();
  }
}
