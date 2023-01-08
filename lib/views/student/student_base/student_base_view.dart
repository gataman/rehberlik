import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_base/cubit/expanded_cubit.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/expand_button.dart';
import '../../../responsive.dart';

abstract class StudentBaseView extends StatelessWidget {
  const StudentBaseView({Key? key}) : super(key: key);

  Widget get firstView;

  Widget get secondView;

  bool get isBack => false;

  bool get isDashboard => false;

  List<BlocProvider<StateStreamableSource<Object?>>>? get providers => null;

  bool get isFullPage => false;

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(minPadding),
      child: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ExpandedCubit(),
          child: BlocBuilder<ExpandedCubit, ExpandedState>(builder: (context, state) {
            bool isExpanded = state.isExpanded;
            return Responsive(
                mobile: isDashboard
                    ? _getMobileDashboardContent(isExpanded, context)
                    : _getMobileContent(isExpanded, context),
                desktop: _getDesktopContent(isExpanded, context));
          }),
        ),
      ),
    );
  }

  Widget _getDesktopContent(bool isExpanded, BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        flex: 4,
        child: firstView,
      ),
      if (!isExpanded)
        const SizedBox(
          width: 4,
        ),
      if (!isFullPage)
        ExpandButton(
          onPressed: () {
            context.read<ExpandedCubit>().changeExpanded();
          },
          isHorizontal: true,
          isExpanded: isExpanded,
        ),
      if (!isExpanded && !isFullPage)
        Expanded(
          flex: 2,
          child: secondView,
        ),
      if (isExpanded && !isFullPage)
        const SizedBox(
          width: 8,
        ),
    ]);
  }

  Widget _getMobileContent(bool isExpanded, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isExpanded && !isFullPage) secondView,
        if (!isFullPage)
          Center(
            child: ExpandButton(
              onPressed: () {
                context.read<ExpandedCubit>().changeExpanded();
              },
              isHorizontal: false,
              isExpanded: isExpanded,
            ),
          ),
        firstView
      ],
    );
  }

  Widget _getMobileDashboardContent(bool isExpanded, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isExpanded) firstView,
        Center(
          child: ExpandButton(
            onPressed: () {
              context.read<ExpandedCubit>().changeExpanded();
            },
            isHorizontal: false,
            isExpanded: isExpanded,
          ),
        ),
        secondView
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return providers != null
        ? MultiBlocProvider(
            providers: providers!,
            child: _content(),
          )
        : _content();
  }
}
