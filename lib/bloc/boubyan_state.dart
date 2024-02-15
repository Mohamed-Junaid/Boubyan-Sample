part of 'boubyan_bloc.dart';

@immutable
abstract class BoubyanState {}

class BoubyanInitial extends BoubyanState {}
class BoubyanBlocLoading extends BoubyanState {}
class BoubyanBlocLoaded extends BoubyanState {}
class BoubyanBlocError extends BoubyanState {}
