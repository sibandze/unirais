import 'package:flutter/material.dart';

import './../../presentation/_presentation.dart' as PRESENTATION;
import './../../util/_util.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String firstName, lastName, email, mobile, password, confirmPassword;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidate: _validate,
      child: new Column(
        children: <Widget>[
          new Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Create new account',
              style: PRESENTATION.SPLASH_TEXT_RIGHT_STYLE,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
              ),
              child: TextFormField(
                validator: validateName,
                onSaved: (String val) {
                  firstName = val;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'First Name',
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
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
              ),
              child: TextFormField(
                validator: validateName,
                onSaved: (String val) {
                  lastName = val;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'Last Name',
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
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: validateMobile,
                onSaved: (String val) {
                  mobile = val;
                },
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'Mobile Number',
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
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: validateEmail,
                onSaved: (String val) {
                  email = val;
                },
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'Email Address',
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
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
              ),
              child: TextFormField(
                obscureText: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                controller: _passwordController,
                validator: validatePassword,
                onSaved: (String val) {
                  password = val;
                },
                style: TextStyle(
                  height: 0.8,
                  fontSize: 18.0,
                ),
                cursorColor: PRESENTATION.PRIMARY_COLOR,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'Password',
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
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                right: 8.0,
                left: 8.0,
              ),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  //_sendToServer();
                },
                obscureText: true,
                validator: (val) =>
                    validateConfirmPassword(_passwordController.text, val),
                onSaved: (String val) {
                  confirmPassword = val;
                },
                style: TextStyle(
                  height: 0.8,
                  fontSize: 18.0,
                ),
                cursorColor: PRESENTATION.PRIMARY_COLOR,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.white,
                  hintText: 'Confirm Password',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 40.0,
              left: 40.0,
              top: 40.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              child: RaisedButton(
                color: PRESENTATION.PRIMARY_COLOR,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Colors.white,
                splashColor: PRESENTATION.PRIMARY_COLOR,
                onPressed: () {
                  //_sendToServer
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Not yet implemented'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                padding: EdgeInsets.only(top: 12, bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(
                    color: PRESENTATION.PRIMARY_COLOR,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
