import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/navigaton/admin_drawer_menu.dart';
import 'package:rehberlik/common/widgets/admin_app_bar.dart';
import 'package:rehberlik/common/widgets/expand_button.dart';
import 'package:rehberlik/core/init/utils.dart';
import 'package:rehberlik/responsive.dart';
import 'package:rehberlik/views/admin/admin_subjects/components/subject_form_box/cubit/edit_subject_cubit.dart';
import 'package:rehberlik/views/admin/admin_subjects/components/subject_list_card/cubit/subject_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_base/cubit/admin_base_cubit.dart';

abstract class AdminBaseViews extends StatelessWidget {
  const AdminBaseViews({Key? key}) : super(key: key);

  Widget get firstView;
  Widget get secondView;
  bool get isBack => false;
  List<BlocProvider<StateStreamableSource<Object?>>>? get providers => null;
  String? get refreshRoute => null;

  @override
  Widget build(BuildContext context) {
    if (refreshRoute != null) {
      Utils.checkRouteArg(context: context, route: refreshRoute!);
    }
    return providers != null
        ? MultiBlocProvider(
            providers: providers!,
            child: _content(),
          )
        : _content();
  }

  Widget _content() {
    return Scaffold(
      appBar: AdminAppBar(),
      drawer: !isBack ? const AdminDrawerMenu() : null,
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => AdminBaseCubit(),
            child: BlocBuilder<AdminBaseCubit, AdminBaseState>(
                builder: (context, state) {
              bool isExpanded = (state as AdminBaseExpandedState).isExpanded;
              return Responsive(
                  mobile: _getMobileContent(isExpanded, context),
                  desktop: _getDesktopContent(isExpanded, context));
            }),
          ),
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
      ExpandButton(
        onPressed: () {
          context.read<AdminBaseCubit>().changeExpanded();
        },
        isHorizontal: true,
        isExpanded: isExpanded,
      ),
      if (!isExpanded)
        Expanded(
          flex: 2,
          child: secondView,
        ),
      if (isExpanded)
        const SizedBox(
          width: 8,
        ),
    ]);
  }

  Widget _getMobileContent(bool isExpanded, BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isExpanded) secondView,
        Center(
          child: ExpandButton(
            onPressed: () {
              context.read<AdminBaseCubit>().changeExpanded();
            },
            isHorizontal: false,
            isExpanded: isExpanded,
          ),
        ),
        firstView,
      ],
    ));
  }
}
