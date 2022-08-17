library admin_uploads_view;

import 'admin_uploads_imports.dart';
part 'components/expansion_student_list.dart';

class AdminUploadsView extends GetView<AdminUploadsController> {
  const AdminUploadsView({Key? key}) : super(key: key);

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
                      controller.selectExcelFile(isEokul: true);
                    },
                    child: const Text("E-Okul Excel Seç")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      controller.selectExcelFile(isEokul: false);
                    },
                    child: const Text("Şablon Seç")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      controller.addAllStudentListWithClass();
                    },
                    child: const Text("Öğrenciler Kaydet")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      controller.selectAllStudentImage();
                    },
                    child: const Text("Toplu Resim Ekle")),
              ),
            ],
          ),
          const Divider(),
          Obx(
            () {
              var data = controller.parsedStudentList.value;
              var addAllStudentOperations =
                  controller.addAllStudentResult.value;

              return Column(
                children: [
                  if (addAllStudentOperations != null &&
                      addAllStudentOperations.isLoading)
                    LinearProgressIndicator(
                      value: addAllStudentOperations.linearValue,
                    ),
                  if (addAllStudentOperations != null &&
                      addAllStudentOperations.isLoading)
                    Center(
                      child: Text(addAllStudentOperations.message),
                    ),
                  if (addAllStudentOperations != null &&
                      !addAllStudentOperations.isLoading)
                    Center(
                      child: Text(addAllStudentOperations.message),
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

  /*
  Future _pickPDFText() async {
    var filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.any, withData: true);
    if (filePickerResult != null) {
      //PDFDoc.fromFile(filePickerResult.files.single.);
      var _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      debugPrint("");
    }
  }

   */
}
