import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

sealed class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

final class StatisticInitial extends StatisticState {}

final class StatisticLoading extends StatisticState {}

final class StatisticSuccess extends StatisticState {
  final List<Decimal> salary;
  final int length;
  const StatisticSuccess({
    required this.salary,
    required this.length,
  });

  @override
  get props => [salary, length];
}

final class StatisticFailure extends StatisticState {
  final String message;

  const StatisticFailure({required this.message});

  @override
  get props => [message];
}
