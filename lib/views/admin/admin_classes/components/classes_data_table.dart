import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ClassesDataTable extends StatelessWidget {
  const ClassesDataTable({
    Key? key,
    required this.classesDataSource,
  }) : super(key: key);

  final ClassesDataSource classesDataSource;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      //verticalScrollPhysics: const NeverScrollableScrollPhysics(),
      allowSorting: true,
      rowHeight: 40,
      headerRowHeight: 40,
      columnWidthMode: ColumnWidthMode.fill,
      source: classesDataSource,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'name',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Sınıf',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ),
        GridColumn(
          columnName: 'opt',
          allowSorting: false,
          label: Row(
            children: [
              const Spacer(
                flex: 2,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child:
                    const Text('İşlem', style: TextStyle(color: primaryColor)),
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ClassesDataSource extends DataGridSource {
  ClassesDataSource({required List<StudentWithClass?>? classList}) {
    if (classList != null) {
      if (classList.isNotEmpty) {
        classList.sort(
            (a, b) => a!.classes.className!.compareTo(b!.classes.className!));
        updateList(classList);
      }
    }
  }

  List<DataGridRow> _classesDataGridRows = [];
  final _controller = Get.put(AdminClassesController());
  final _adminViewController = Get.put(AdminViewController());

  @override
  List<DataGridRow> get rows => _classesDataGridRows;

  void updateList(List<StudentWithClass?>? newList) {
    if (newList != null) {
      if (newList.isNotEmpty) {
        newList.sort(
            (a, b) => a!.classes.className!.compareTo(b!.classes.className!));

        _classesDataGridRows = newList
            .asMap()
            .map((i, studentWithClass) => MapEntry(
                i,
                DataGridRow(cells: <DataGridCell>[
                  DataGridCell<Widget>(
                      columnName: 'name',
                      value: Text(
                        studentWithClass!.classes.className.toString(),
                        overflow: TextOverflow.ellipsis,
                      )),
                  DataGridCell<Widget>(
                    columnName: 'opt',
                    value: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(
                          flex: 3,
                        ),
                        Row(
                          children: [
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  _showClassDetail(studentWithClass.classes, i);
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.lightBlueAccent,
                                )),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  _editClass(studentWithClass.classes);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.lightGreen,
                                )),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  _deleteClass(studentWithClass.classes);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                )),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                ])))
            .values
            .toList();
        notifyListeners();
      }
    }
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.runtimeType == DataGridCell<Widget>) {
        return Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: e.value,
        );
      } else {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.value.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        );
      }
    }).toList());
  }

  void _showClassDetail(Classes classes, int index) {
    _controller.showClassDetail(classes);
    _controller.selectedIndex.value = index;

    _adminViewController.selectMenuItem(2);
  }

  void _editClass(Classes classes) {
    _controller.editClass(classes);
  }

  void _deleteClass(Classes classes) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${classes.className} adlı sınıfı silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        _controller.deleteClass(classes);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
