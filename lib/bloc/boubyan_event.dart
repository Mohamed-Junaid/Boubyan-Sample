part of 'boubyan_bloc.dart';

@immutable
abstract class BoubyanEvent {}
class FetchBoubyan extends BoubyanEvent {
  final String name;
  final String dob;
  final String mobile;
  final String gender;
  final String isSelectedClient;
  final String isSelectedNotClient;


  FetchBoubyan ({required this.dob,required this.mobile,
    required this.gender, required this.isSelectedClient, required this.isSelectedNotClient,
    required this.name,});
}
