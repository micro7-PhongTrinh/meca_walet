import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meca_service/exception/meca_service_exception.dart';
import 'package:meca_service/meca_service.dart';

part 'google_signin_state.dart';
part 'google_signin_event.dart';

class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  final MecaService _mecaService;
  GoogleSignupBloc(MecaService mecaService)
      : _mecaService = mecaService,
        super(GoogleSignupInitialState()) {
    on<SignUpByGoogleEvent>(
        (GoogleSignupEvent event, Emitter<GoogleSignupState> emit) async {
      await _signInGoogle(emit);
    });
  }

  Future<dynamic> _signInGoogle(Emitter<GoogleSignupState> emit) async {
    emit(GoogleSigningUpState());
    try {
      User user = await _mecaService.signinGoogle();
      emit(GoogleSignupSucceedState(user));
    } on MecaServiceException catch (e) {
      if (e is SigninFailRequest) {
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
