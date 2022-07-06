import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_controller.dart';
import 'package:rehberlik/views/admin/admin_uploads/components/expansion_student_list.dart';

class AdminUploadsView extends StatefulWidget {
  const AdminUploadsView({Key? key}) : super(key: key);

  @override
  State<AdminUploadsView> createState() => _AdminUploadsViewState();
}

class _AdminUploadsViewState extends State<AdminUploadsView> {
  PlatformFile? pickedFile;
  final _controller = Get.put(AdminUploadsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      _controller.selectExcelFile(isEokul: true);
                    },
                    child: Text("E-Okul Excel Seç")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      _controller.selectExcelFile(isEokul: false);
                    },
                    child: Text("Şablon Seç")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      _controller.addAllStudentListWithClass();
                    },
                    child: Text("Öğrenciler Kaydet")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      _controller.selectAllStudentImage();
                    },
                    child: Text("Toplu Resim Ekle")),
              ),
            ],
          ),
          const Divider(),
          Obx(
            () {
              var data = _controller.parsedStudentList.value;
              var addAllStudentOperations =
                  _controller.addAllStudentResult.value;

              return Column(
                children: [
                  if (addAllStudentOperations != null &&
                      addAllStudentOperations.isLoading)
                    LinearProgressIndicator(
                      value: addAllStudentOperations.linearValue,
                    ),
                  if (addAllStudentOperations != null &&
                      addAllStudentOperations.isLoading)
                    Container(
                      child: Center(
                        child: Text(addAllStudentOperations.message),
                      ),
                    ),
                  if (addAllStudentOperations != null &&
                      !addAllStudentOperations.isLoading)
                    Container(
                      child: Center(
                        child: Text(addAllStudentOperations.message),
                      ),
                    ),
                  if (data != null) ExpansionStudentList(data: data)
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future _pickPDFText() async {
    var filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.any, withData: true);
    if (filePickerResult != null) {
      //PDFDoc.fromFile(filePickerResult.files.single.);
      var _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      debugPrint("");
    }
  }
}
