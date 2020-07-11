import 'package:flutter/material.dart';

import './../../../presentation/_presentation.dart' as PRESENTATION;

class AccountDetailsForm extends StatefulWidget {
  @override
  _AccountDetailsFormState createState() => _AccountDetailsFormState();
}

class _AccountDetailsFormState extends State<AccountDetailsForm> {
  TextEditingController _emailController;
  TextEditingController _phoneNumberController;

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
            controller: _emailController,
            style: TextStyle(
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.emailAddress,
            cursorColor: PRESENTATION.PRIMARY_COLOR,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              fillColor: Colors.white,
              hintText: 'E-mail Address',
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
            controller: _phoneNumberController,
            style: TextStyle(
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.phone,
            cursorColor: PRESENTATION.PRIMARY_COLOR,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              fillColor: Colors.white,
              hintText: 'E-mail Address',
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
    _emailController = new TextEditingController(
      text: 'nkosingphiless@gmail.com',
    );
    _phoneNumberController = new TextEditingController(
      text: '0789860009',
    );
    super.initState();
  }
}
