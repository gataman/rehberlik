part of 'admin_base_cubit.dart';

abstract class AdminBaseState {}

class AdminBaseExpandedState extends AdminBaseState {
  final bool isExpanded;

  AdminBaseExpandedState(this.isExpanded);
}
