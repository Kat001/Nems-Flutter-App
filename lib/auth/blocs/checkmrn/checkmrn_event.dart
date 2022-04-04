part of 'checkmrn_bloc.dart';

abstract class CheckmrnEvent extends Equatable {
  const CheckmrnEvent();

  @override
  List<Object> get props => [];
}

class MrnTextChangedEvent extends CheckmrnEvent {
  final String mrn;

  const MrnTextChangedEvent(this.mrn);
}

class MrnSubmittedEvent extends CheckmrnEvent {
  final String mrn;

  const MrnSubmittedEvent(this.mrn);
}
