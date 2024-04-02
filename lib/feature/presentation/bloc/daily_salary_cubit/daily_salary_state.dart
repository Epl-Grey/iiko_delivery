part of 'daily_salary_cubit.dart';

sealed class DailySalaryState extends Equatable {
  const DailySalaryState();

  @override
  List<Object> get props => [];
}

final class DailySalaryInitial extends DailySalaryState {}

final class DailySalaryLoading extends DailySalaryState {}

final class DailySalarySuccess extends DailySalaryState {
  final Decimal salary;

  const DailySalarySuccess({required this.salary});

  @override
  get props => [salary];
}

final class DailySalaryFailure extends DailySalaryState {
  final String message;

  const DailySalaryFailure({required this.message});

  @override
  get props => [message];
}