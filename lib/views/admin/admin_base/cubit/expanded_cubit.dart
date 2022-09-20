import 'package:flutter_bloc/flutter_bloc.dart';

part 'expanded_state.dart';

class ExpandedCubit extends Cubit<ExpandedState> {
  ExpandedCubit() : super(ExpandedState(false));
  bool isExpanded = false;

  void changeExpanded() {
    isExpanded = !isExpanded;
    emit(ExpandedState(isExpanded));
  }
}
