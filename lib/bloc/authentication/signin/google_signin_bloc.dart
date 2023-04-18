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
      final UserModel user = await _authenticationService.signinGoogle();
      emit(GoogleSignupSucceedState(user));
    } on AuthenticationFailedException catch (e) {
      if (e.isUserCanceled) {
        emit(GoogleSignupInitialState());
      } else {
        emit(GoogleSignupFailedState(e.error));
      }
    } catch (e) {
      emit(GoogleSignupFailedState(
          'Something wrong happened. Please try again later'));
    }
  }
}
