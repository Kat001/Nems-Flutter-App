import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:nems/auth/models/verify_dob.dart';
import 'package:nems/auth/models/verify_mrn_model.dart';

import 'package:nems/auth/repositories/user_repository.dart';
import 'package:nems/auth/repositories/user_repository_impl.dart';
import 'package:nems/auth/services/login_service.dart';
import 'package:nems/core/api_client.dart';
import 'package:nems/core/app_error.dart';

part 'check_dob_event.dart';
part 'check_dob_state.dart';

class CheckDobBloc extends Bloc<CheckDobEvent, CheckDobState> {
  CheckDobBloc() : super(CheckDobInitialState()) {
    ApiClient apiClient = ApiClient(Client());
    LoginUser loginUser = LoginUserImpl(apiClient);
    UserRepository userRepository = UserRepositoryImpl(loginUser);

    on<DobSubmittedEvent>((event, emit) async {
      emit(CheckDobLoadingState());
      var data = {
        'dob': event.dob,
        'firstName': event.firstname,
        'lastName': event.lastname
      };
      final Either<AppError, DobData> eitherresponse =
          await userRepository.verifyDob(data);

      eitherresponse.fold((l) {
        emit(const CheckDobErrorState("MRN does not exists"));
        emit(CheckDobInitialState());
      }, (r) {
        if (r.status == 'success') {
          emit(CheckDobSuccessState(r));
        } else {
          emit(CheckDobInitialState());
        }
      });
    });
  }
}
