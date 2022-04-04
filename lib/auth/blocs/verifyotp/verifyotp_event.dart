part of 'verifyotp_bloc.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpChangedEvent extends VerifyOtpEvent {
  final String otp;
  const VerifyOtpChangedEvent(this.otp);
}

class VerifyOtpSubmittedEvent extends VerifyOtpEvent {
  final String otp;
  final String? mrn;

  const VerifyOtpSubmittedEvent(this.otp, this.mrn);
}
