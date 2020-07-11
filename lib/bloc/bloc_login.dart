import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './../repository/_repository.dart';
import './bloc_authentication.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocLogin extends Bloc<BlocEventLogin, LoginState> {
  final UserRepository userRepository = UserRepository();
  final BlocAuthentication authenticationBloc;

  BlocLogin({@required this.authenticationBloc})
      : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(BlocEventLogin event) async* {
    if (event is BlocEventLoginButtonPressed) {
      yield LoginLoading();

      try {
        final String token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        /*await Future.delayed(Duration(
          milliseconds: PRODUCT_LOADING_TIME,
        ));*/
        yield LoginSuccess(token: token);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
