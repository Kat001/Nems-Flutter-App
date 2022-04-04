part of 'checkmrn_bloc.dart';

abstract class CheckMrnState extends Equatable {
  const CheckMrnState();

  @override
  List<Object> get props => [];
}

class CheckMrnInitialState extends CheckMrnState {}

class CheckMrnLoadingState extends CheckMrnState {}

class CheckMrnValidState extends CheckMrnState {}

class CheckMrnSuccessState extends CheckMrnState {
  final MrnData mrnData;

  const CheckMrnSuccessState(this.mrnData);
  @override
  List<Object> get props => [mrnData];
}

class CheckMrnErrorState extends CheckMrnState {
  final String errorMesage;
  const CheckMrnErrorState(this.errorMesage);
}

class CheckMrnInValidState extends CheckMrnState {
  final String errorMesage;
  const CheckMrnInValidState(this.errorMesage);
}
