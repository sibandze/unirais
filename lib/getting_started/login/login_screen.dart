import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';

import './../../bloc/_bloc.dart';
import './../../presentation/_presentation.dart' as PRESENTATION;
import './login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BlocAuthentication _authenticationBloc;
  BlocLogin _loginBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<BlocAuthentication>(context);
    _loginBloc = BlocLogin(authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _loginBloc,
      child: _Page(),
    );
  }
}

//

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  BlocLogin _loginBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: LoginForm(),
          ),
          BlocBuilder<BlocLogin, LoginState>(
            bloc: _loginBloc,
            builder: (BuildContext context, LoginState state) {
              if (state is LoginLoading) {
                return Container(
                  color: PRESENTATION.TITLE_TEXT_COLOR.withOpacity(0.75),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LoadingBouncingGrid.circle(
                          inverted: true,
                          borderColor: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          "Logging you in...",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<BlocLogin>(context);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
