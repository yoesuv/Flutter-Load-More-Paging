import 'package:equatable/equatable.dart';

abstract class HomeListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeListEventLoad extends HomeListEvent {}