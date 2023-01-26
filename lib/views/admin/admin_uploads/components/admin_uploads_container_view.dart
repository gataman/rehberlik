import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/containers/app_list_box_container.dart';
import 'cubit/admin_uploads_cubit.dart';

import 'upload_excel_view/upload_excel_view.dart';
import 'upload_student_image_view/upload_student_images_view.dart';

class AdminUploadsContainerView extends StatelessWidget {
  const AdminUploadsContainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBoxContainer(
      child: BlocBuilder<AdminUploadsCubit, AdminUploadsState>(builder: (context, state) {
        if (state is AdminUploadsExcelState) {
          return const UploadExcelView(
            isEokul: true,
          );
        } else if (state is AdminUploadsTemplateState) {
          return const UploadExcelView(
            isEokul: false,
          );
        } else if (state is AdminUploadsPhotoState) {
          return const UploadStudentImagesView();
        } else {
          return _defaultType();
        }
      }),
    );
  }

  Widget _defaultType() {
    return const Text("Bir hata oluştu!");
  }
}
