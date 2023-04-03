import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../admin_base/admin_base_view.dart';
import 'components/admin_uploads_container_view.dart';
import 'components/admin_uploads_menu.dart';
import 'components/cubit/admin_uploads_cubit.dart';

class AdminUploadsView extends AdminBaseView {
  const AdminUploadsView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const AdminUploadsContainerView();

  @override
  Widget get secondView => const AdminUploadsMenu();

  @override
  List<BlocProvider<StateStreamableSource<Object?>>> get providers {
    final providers = <BlocProvider>[
      BlocProvider<AdminUploadsCubit>(create: (_) => AdminUploadsCubit()),
    ];
    return providers;
  }
}
