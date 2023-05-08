import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication/authentication.dart';

part 'google_signin_state.dart';
part 'google_signin_event.dart';

class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  final AuthenticationService _authenticationService;
  GoogleSignupBloc(AuthenticationService authenticationService)
      : _authenticationService = authenticationService,
        super(GoogleSignupInitialState()) {
    on<SignUpByGoogleEvent>(
        (GoogleSignupEvent event, Emitter<GoogleSignupState> emit) async {
      await _signInGoogle(emit);
    });
  }

  Future<dynamic> _signInGoogle(Emitter<GoogleSignupState> emit) async {
    emit(GoogleSigningUpState());
    try {
      print('11111');
      final UserModel user = await _authenticationService.signinGoogle();

      print('22222');
      print(user.toString());
      emit(GoogleSignupSucceedState(user));
    } on AuthenticationFailedException catch (e) {
      if (e.isUserCanceled) {
        print('33333');
        emit(GoogleSignupInitialState());
      } else {
        print('444444');
        print(e.error.toString());
        emit(GoogleSignupFailedState(e.error));
      }
    } catch (e) {
      print('55555');
      print(e.toString());
      emit(GoogleSignupFailedState(
          'Something wrong happened. Please try again later'));
    }
  }
}
