import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:nems/auth/models/auth_user_model.dart';
import 'package:nems/auth/repositories/user_repository.dart';
import 'package:nems/auth/repositories/user_repository_impl.dart';
import 'package:nems/auth/services/login_service.dart';

import 'package:nems/core/api_client.dart';
import 'package:nems/core/app_error.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'verifyotp_event.dart';
part 'verifyotp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitialState()) {
    ApiClient apiClient = ApiClient(Client());
    LoginUser loginUser = LoginUserImpl(apiClient);
    UserRepository userRepository = UserRepositoryImpl(loginUser);
    on<VerifyOtpChangedEvent>((event, emit) {
      print(event.otp);
      if (event.otp.length == 6) {
        emit(VerifyOtpValidState());
      } else {
        emit(VerifyOtpInitialState());
      }
    });

    on<VerifyOtpSubmittedEvent>((event, emit) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      emit(VerifyOtpLoadingstate());
      var data = {
        'mrn': event.mrn,
        'code': event.otp,
      };
      final Either<AppError, AuthUser> eitherresponse =
          await userRepository.loginUser(data);
      eitherresponse.fold((l) {
        emit(VerifyOtpErrorState());
      }, (r) async {
        _prefs.setString('access', r.access!);
        _prefs.setString('refresh', r.refresh!);
        _prefs.setString('id', r.user!.data!.id!);
        _prefs.setString('mrn', r.user!.data!.mrn!);
        _prefs.setString('firstName', r.user!.data!.firstName!);
        _prefs.setString('lastName', r.user!.data!.lastName!);
        _prefs.setString('email', r.user!.data!.email!);
        _prefs.setString('phone', r.user!.data!.phone!);
        _prefs.setInt('preferredLocation', r.user!.preferredLocation!);
        _prefs.setString('locationAddress', r.user!.locationAddress!);
        emit(VerifyOtpSuccessState());
      });
    });
  }
}
