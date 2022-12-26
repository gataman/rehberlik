import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/cubit/uploads_type.dart';

part 'admin_uploads_state.dart';

class AdminUploadsCubit extends Cubit<AdminUploadsState> {
  AdminUploadsCubit() : super(AdminUploadsExcelState());

  void changeUplaodType({required UploadType type}) {
    switch (type) {
      case UploadType.excel:
        emit(AdminUploadsExcelState());
        break;
      case UploadType.template:
        emit(AdminUploadsTemplateState());
        break;
      case UploadType.photo:
        emit(AdminUploadsPhotoState());
        break;
    }
  }
}
