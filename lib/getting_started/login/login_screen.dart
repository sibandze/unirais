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
  //BlocAuthentication _authenticationBloc;
  //BlocLogin _loginBloc;

  @override
  void initState() {
    //_authenticationBloc = BlocProvider.of<BlocAuthentication>(context);
    //_loginBloc = BlocLogin(authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BlocLogin(
          authenticationBloc: BlocProvider.of<BlocAuthentication>(context)),
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
//  BlocLogin _loginBloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
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
            ],
          ),
        ),
        BlocBuilder<BlocLogin, LoginState>(
          builder: (BuildContext context, LoginState state) {
            if (state is LoginLoading) {
              return SafeArea(
                child: Container(
                  color: PRESENTATION.BACKGROUND_COLOR,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LoadingBouncingGrid.circle(
                          inverted: true,
                          borderColor: PRESENTATION.PRIMARY_COLOR,
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          "Logging you in...",
                          style: TextStyle(
                              fontSize: 20,
                            fontFamily: 'Poppins',
                            color: PRESENTATION.TEXT_LIGHT_COLOR,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
