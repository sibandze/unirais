import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../bloc/_bloc.dart';
import './../../presentation/_presentation.dart' as PRESENTATION;
import './../../util/_util.dart';
import '../../main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  BlocLogin _loginBloc; // TODO
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String email, password;

  void _onLoginButtonPressed() async {
    _loginBloc.add(
      BlocEventLoginButtonPressed(
        username: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  Widget socialLoginButton(SocialMediaType _socialMediaType) {
    var _icon;
    var _color;
    var _title;

    switch (_socialMediaType) {
      case SocialMediaType.FACEBOOK:
        _icon = Icon(PRESENTATION.Font_awesome_icons.facebook_official);
        _color = Color(0xFF415893);
        _title = "Facebook Login";
        break;
      case SocialMediaType.TWITTER:
        _icon = Icon(PRESENTATION.Font_awesome_icons.twitter);
        _color = Color(0xFF1DA1F2);
        _title = "Twitter Login";
        break;
      case SocialMediaType.GOOGLE:
        _icon = Icon(PRESENTATION.Font_awesome_icons.google);
        _color = Color(0xFFC23B2B);
        _title = "Google Login";
        break;
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32.0,
        ),
        child: RaisedButton.icon(
          elevation: 1.0,
          onPressed: () async {
            /// LOG BUTTON
            _onWidgetDidBuild(
              () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Not yet implemented'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
            //_onLoginButtonPressed();
          },
          label: Text(
            _title,
            style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          icon: _icon,
          padding: EdgeInsets.all(15),
          color: _color,
          textColor: Colors.white,
          splashColor: Color(0xFF415893),
        ),
      ),
    );
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<BlocLogin>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocLogin, LoginState>(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFailure)
          _onWidgetDidBuild(
            () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        else if (state is LoginSuccess)
          _onWidgetDidBuild(
            () {
              pushAndRemoveUntil(context, UniRaisAppHome(), false);
            },
          );
      },
      child: BlocBuilder<BlocLogin, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Form(
            key: _key,
            autovalidate: _validate,
            child: ListView(
              children: <Widget>[
                Text(
                  'Sign In',
                  style: PRESENTATION.SPLASH_TEXT_RIGHT_STYLE,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      validator: validateEmail,
                      onSaved: (String val) {
                        email = val;
                      },
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
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
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      textAlignVertical: TextAlignVertical.center,
                      validator: validatePassword,
                      onSaved: (String val) {
                        email = val;
                      },
                      onFieldSubmitted: (password) async {
                        if (state is! LoginLoading && state is! LoginSuccess)
                          _onLoginButtonPressed();
                      },
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      cursorColor: PRESENTATION.PRIMARY_COLOR,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.only(
                          left: 16,
                          right: 16,
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
                  constraints: const BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                    ),
                    child: RaisedButton(
                      elevation: 1.0,
                      onPressed: () async {
                        if (state is! LoginLoading && state is! LoginSuccess)
                          _onLoginButtonPressed();
                      },
                      child: Text(
                        'Log In',
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                  ),
                  child: Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                socialLoginButton(SocialMediaType.GOOGLE),
                socialLoginButton(SocialMediaType.FACEBOOK),
                socialLoginButton(SocialMediaType.TWITTER),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}

enum SocialMediaType { FACEBOOK, TWITTER, GOOGLE }
