import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../common/locator.dart';
import '../../../../../../core/init/locale_manager.dart';
import '../../../../../../core/init/pref_keys.dart';
import '../../../../../../models/student.dart';
import '../../../../../../repository/student_repository.dart';

part 'upload_student_image_state.dart';

class UploadStudentImageCubit extends Cubit<UploadStudentImageState> {
  UploadStudentImageCubit() : super(UploadStudentImageDefaultState());

  final _studentRepository = locator<StudentRepository>();

  Future<void> selectAllStudentImage() async {
    //final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    final ImagePicker picker = ImagePicker();
    final List<XFile?> images = await picker.pickMultiImage(maxWidth: 256);
    final schoolID = SharedPrefs.instance.getString(PrefKeys.schoolID.toString());
    debugPrint(images.isEmpty.toString());

    if (images.isNotEmpty && schoolID != null) {
      var totalImagesCount = images.length;
      emit(UploadStudentImageLoadingState(isLoading: true, totalImageCount: totalImagesCount, loadedImageCount: 0));
      List<Student> studentList = await _studentRepository.getAllWithSchoolID(schoolID: schoolID);

      List<Student> editingStudentList = <Student>[];

      int loadedImageCount = 0;

      for (var studentImage in images) {
        if (studentImage != null) {
          final studentNumber = studentImage.name.split(".")[0].replaceAll("scaled_", "");

          var studentSearchList = studentList.where((element) => element.studentNumber == studentNumber);
          if (studentSearchList.isNotEmpty) {
            Student student = studentSearchList.first;

            await _studentRepository
                .uploadStudentImage(imageFile: studentImage, schoolID: schoolID, imageFileName: "$studentNumber.jpeg")
                .then((imageUrl) {
              student.photoUrl = imageUrl;
              editingStudentList.add(student);
            });
            loadedImageCount++;

            emit(UploadStudentImageLoadingState(
                isLoading: true, totalImageCount: totalImagesCount, loadedImageCount: loadedImageCount));
          } else {
            debugPrint("Bu numara bulunamadı : $studentNumber");
          }
        }
      }

      await _studentRepository.updateAll(list: editingStudentList);
      emit(UploadStudentImageLoadedState());
    } else {
      emit(UploadStudentImageLoadedState(hasError: true));
    }
  }
}
