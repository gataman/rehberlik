import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_base_state.dart';

class AdminBaseCubit extends Cubit<AdminBaseState> {
  AdminBaseCubit() : super(AdminBaseExpandedState(false));

  void changeExpanded() {
    emit(AdminBaseExpandedState(!(state as AdminBaseExpandedState).isExpanded));
  }
}
