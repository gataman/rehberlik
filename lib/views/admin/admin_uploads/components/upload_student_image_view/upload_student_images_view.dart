import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/upload_student_image_view/cubit/upload_student_image_cubit.dart';

class UploadStudentImagesView extends StatelessWidget {
  const UploadStudentImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Center(
        child: BlocProvider<UploadStudentImageCubit>(
          create: (_) => UploadStudentImageCubit(),
          child: BlocBuilder<UploadStudentImageCubit, UploadStudentImageState>(
            builder: (context, state) {
              if (state is UploadStudentImageLoadingState) {
                return _loadingState(state);
              } else if (state is UploadStudentImageLoadedState) {
                return _loadedState(state, context);
              } else {
                return _defaultState(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingState(UploadStudentImageLoadingState state) {
    double linearValue = 0;
    if (state.loadedImageCount > 0 && state.totalImageCount > 0) {
      linearValue = state.loadedImageCount.toDouble() / state.totalImageCount.toDouble();
    }
    return Column(
      children: [
        const Text(
          "Fotoğraflar yükleniyor. Lütfen bekleyin!..",
          style: defaultTitleStyle,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        LinearProgressIndicator(
          value: linearValue,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Text("Yüklenen fotoğraf sayısı: ${state.loadedImageCount} / ${state.totalImageCount}")
      ],
    );
  }

  Widget _loadedState(UploadStudentImageLoadedState state, BuildContext context) {
    if (!state.hasError) {
      context.read<ClassListCubit>().fetchClassList();
      return const Text("Fotoğraf yükleme işlemi başarıyla tamamlandı");
    } else {
      return const Text("Yükleme işlemi sırasında bir hata oluştu");
    }
  }

  Widget _defaultState(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.amber),
          onPressed: () {
            context.read<UploadStudentImageCubit>().selectAllStudentImage();
          },
          child: const Text(
            "Fotoğrafları Yükle",
            style: TextStyle(color: darkBackColor),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        const Text(
            "Öğrenci fotoğraflarını numaralarıyla isimlendirdikten sonra bu alandan topluca yükleyebilirsiniz!")
      ],
    );
  }
}
