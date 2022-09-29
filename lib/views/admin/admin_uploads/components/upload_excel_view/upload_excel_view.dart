import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/widgets/button_with_icon.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_imports.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/upload_excel_view/cubit/upload_excel_cubit.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../expansion_student_list.dart';

class UploadExcelView extends StatelessWidget {
  final bool isEokul;

  const UploadExcelView({Key? key, required this.isEokul}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Center(
        child: BlocProvider<UploadExcelCubit>(
          create: (_) => UploadExcelCubit(),
          child: BlocBuilder<UploadExcelCubit, UploadExcelState>(
            builder: (context, state) {
              if (state is UploadExcelParsedState) {
                return _excelParsedState(state, context);
              } else if (state is UploadExcelSavedState) {
                return _excelSavedState(state, context);
              } else {
                return _defaultState(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Column _defaultState(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_excelUploadInfo(context), _uploadButton(context)],
    );
  }

  Widget _excelUploadInfo(BuildContext context) {
    if (isEokul) {
      return Text(
        "E-okul Öğrenci İşlemleri kısmından aldığınız Fotoğraflı Kimlik Bilgili Öğrenci listesini "
        "önce excelden açınız ve xlsx formatına dönüştürdükten sonra "
        "bu alana yükleyiniz!",
        style: Theme.of(context).textTheme.bodyLarge,
      );
    } else {
      return Column(
        children: [
          SizedBox(
            width: 200,
            child: ButtonWithIcon(
                labelText: "Excel Şablonu İndir",
                icon: Icons.download,
                onPressed: () {
                  openInANewTab(
                      'https://firebasestorage.googleapis.com/v0/b/rehberlik-810e1.appspot.com/o/documents%2Fsablon_liste.xlsx?alt=media&token=f3fdf075-8aa6-4159-a69e-197fdac4f9cd');
                }),
          ),
          Text(
            "Yukarıdaki excel şablonunu bilgisayarınıza indirip öğrencileri doldurun ve bu alana yükleyin",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      );
    }
  }

  Widget _uploadButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        onPressed: () {
          context.read<UploadExcelCubit>().selectExcelFile(isEokul: isEokul);
        },
        child: const Text(
          "Dosya Yükle",
          style: TextStyle(color: darkBackColor),
        ),
      ),
    );
  }

  Widget _excelParsedState(UploadExcelParsedState state, BuildContext context) {
    if (state.isLoading) {
      return Column(
        children: [
          const SizedBox(
            width: defaultPadding,
            height: defaultPadding,
            child: DefaultCircularProgress(),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Text(
            "Dosya yükleniyor lütfen bekleyin!",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      );
    } else {
      if (state.parsedStudentList != null) {
        return Column(
          children: [
            const Text("Dosya başarıyla yüklendi. Kontrol ettikten sonra sisteme kaydedin!"),
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  context.read<UploadExcelCubit>().addAllStudentListWithClass();
                },
                child: const Text(
                  "Sisteme Kaydet",
                  style: TextStyle(color: darkBackColor),
                ),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            ExpansionStudentList(data: state.parsedStudentList!)
          ],
        );
      } else {
        return const Text("İşlem sırasında bir hata oluştu");
      }
    }
  }

  Widget _excelSavedState(UploadExcelSavedState state, BuildContext context) {
    if (state.isLoading) {
      return _loadingMessageView(message: "Sisteme kaydediliyor lütfen bekleyin!");
    } else {
      if (!state.hasError) {
        context.read<ClassListCubit>().fetchClassList();
        return const Text(
          "Kayıt işlemi başarıyla yapıldı!",
          style: defaultTitleStyle,
        );
      } else {
        return const Text("Sistemde bir hata oluştu!");
      }
    }
  }

  Widget _loadingMessageView({required String message}) {
    return Column(
      children: [
        const SizedBox(
          width: defaultPadding,
          height: defaultPadding,
          child: DefaultCircularProgress(),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(message)
      ],
    );
  }

  void openInANewTab(url) {
    if (kIsWeb) {
      html.window.open(url, 'PlaceholderName');
    }
  }
}
