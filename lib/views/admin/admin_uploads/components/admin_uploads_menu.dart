import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/constants.dart';
import '../../../../common/widgets/button_with_icon.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import '../../../../core/widgets/text/app_menu_title.dart';
import 'cubit/admin_uploads_cubit.dart';
import 'cubit/uploads_type.dart';

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
          ButtonWithIcon(
            labelText: "TC ve Salon Bilgileri",
            icon: Icons.image,
            onPressed: () => cubit.changeUplaodType(type: UploadType.tc),
          ),
        ],
      ),
    ));
  }
}
