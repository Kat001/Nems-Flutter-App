part of 'verifyotp_bloc.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingstate extends VerifyOtpState {}

class VerifyOtpSuccessState extends VerifyOtpState {}

class VerifyOtpValidState extends VerifyOtpState {}

class VerifyOtpErrorState extends VerifyOtpState {}
