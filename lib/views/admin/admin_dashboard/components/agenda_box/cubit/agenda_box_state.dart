part of 'agenda_box_cubit.dart';

@immutable
abstract class AgendaBoxState {}

class AgendaBoxInitial extends AgendaBoxState {
  final bool isLoading;
  final List<Meeting>? meetingList;

  AgendaBoxInitial({this.isLoading = true, this.meetingList});
}
