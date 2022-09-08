import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_views.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/admin_uploads_container_view.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/admin_uploads_menu.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/cubit/admin_uploads_cubit.dart';

class AdminUploadsView extends AdminBaseViews {
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
