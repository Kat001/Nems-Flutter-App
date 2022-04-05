part of 'check_dob_bloc.dart';

abstract class CheckDobEvent extends Equatable {
  const CheckDobEvent();

  @override
  List<Object> get props => [];
}

class DobSubmittedEvent extends CheckDobEvent {
  final String dob;
  final String firstname;
  final String lastname;

  const DobSubmittedEvent(this.dob, this.firstname, this.lastname);
}
