import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:nems/auth/models/verify_mrn_model.dart';
import 'package:nems/auth/repositories/user_repository.dart';
import 'package:nems/auth/repositories/user_repository_impl.dart';
import 'package:nems/auth/services/login_service.dart';
import 'package:nems/core/api_client.dart';
import 'package:nems/core/app_error.dart';

part 'checkmrn_event.dart';
part 'checkmrn_state.dart';

class CheckMrnBloc extends Bloc<CheckmrnEvent, CheckMrnState> {
  CheckMrnBloc() : super(CheckMrnInitialState()) {
    ApiClient apiClient = ApiClient(Client());
    LoginUser loginUser = LoginUserImpl(apiClient);
    UserRepository userRepository = UserRepositoryImpl(loginUser);

    on<MrnTextChangedEvent>((event, emit) {
      if (event.mrn.length < 7) {
        emit(const CheckMrnInValidState("length must be 7"));
      } else {
        emit(CheckMrnValidState());
      }
    });

    on<MrnSubmittedEvent>((event, emit) async {
      emit(CheckMrnLoadingState());
      var data = {'mrn': event.mrn};
      final Either<AppError, MrnData> eitherresponse =
          await userRepository.verifyMrn(data);
      eitherresponse.fold((l) {
        emit(const CheckMrnErrorState("MRN does not exists"));
        emit(CheckMrnInitialState());
      }, (r) {
        if (r.status == 'success') {
          emit(CheckMrnSuccessState(r));
        } else {
          emit(CheckMrnInitialState());
        }
      });
    });
  }
}
