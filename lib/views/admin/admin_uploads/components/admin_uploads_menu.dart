import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/button_with_icon.dart';
import 'package:rehberlik/core/widgets/containers/app_list_box_container.dart';
import 'package:rehberlik/core/widgets/text/app_menu_title.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/cubit/admin_uploads_cubit.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/cubit/uploads_type.dart';

class AdminUploadsMenu extends StatelessWidget {
  const AdminUploadsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminUploadsCubit>();
    return AppBoxContainer(
        child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          const AppMenuTitle(title: "İşlemler"),
          ButtonWithIcon(
            labelText: "E-Okul Excel'den Yükle",
            icon: Icons.upload_file,
            onPressed: () => cubit.changeUplaodType(type: UploadType.excel),
          ),
          ButtonWithIcon(
            labelText: "Şablondan Yükle",
            icon: Icons.file_upload_outlined,
            onPressed: () => cubit.changeUplaodType(type: UploadType.template),
          ),
          ButtonWithIcon(
            labelText: "Toplu Fotoğraf Yükle",
            icon: Icons.image,
            onPressed: () => cubit.changeUplaodType(type: UploadType.photo),
          ),
        ],
      ),
    ));
  }
}
