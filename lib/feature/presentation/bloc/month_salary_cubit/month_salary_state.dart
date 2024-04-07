import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

sealed class MonthSalaryState extends Equatable {
  const MonthSalaryState();

  @override
  List<Object> get props => [];
}

final class MonthSalaryInitial extends MonthSalaryState {}

final class MonthSalaryLoading extends MonthSalaryState {}

final class MonthSalarySuccess extends MonthSalaryState {
  final Decimal salary;

  const MonthSalarySuccess({required this.salary});

  @override
  get props => [salary];
}

final class MonthSalaryFailure extends MonthSalaryState {
  final String message;

  const MonthSalaryFailure({required this.message});

  @override
  get props => [message];
}

