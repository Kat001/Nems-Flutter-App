part of 'check_dob_bloc.dart';

abstract class CheckDobState extends Equatable {
  const CheckDobState();

  @override
  List<Object> get props => [];
}

class CheckDobInitialState extends CheckDobState {}

class CheckDobLoadingState extends CheckDobState {}

class CheckDobSuccessState extends CheckDobState {
  final DobData dobData;

  const CheckDobSuccessState(this.dobData);
  @override
  List<Object> get props => [dobData];
}

class CheckDobErrorState extends CheckDobState {
  final String errorMesage;
  const CheckDobErrorState(this.errorMesage);
}
