import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/classes.dart';
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
      shrinkWrapRows: true,
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
          columnName: 'level',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'Sınıf Seviyesi',
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
  ClassesDataSource({required List<Classes?>? classList}) {
    if (classList != null) {
      if (classList.isNotEmpty) {
        classList.sort((a, b) => a!.className!.compareTo(b!.className!));
        updateList(classList);
      }
    }
  }

  List<DataGridRow> _classesDataGridRows = [];
  final _controller = Get.put(AdminClassesController());

  @override
  List<DataGridRow> get rows => _classesDataGridRows;

  void updateList(List<Classes?>? newList) {
    if (newList != null) {
      if (newList.isNotEmpty) {
        newList.sort((a, b) => a!.className!.compareTo(b!.className!));
        _classesDataGridRows = newList
            .map<DataGridRow>(
              (classes) => DataGridRow(
                cells: <DataGridCell>[
                  DataGridCell<String>(
                      columnName: 'name', value: classes!.className),
                  DataGridCell<String>(
                      columnName: 'level',
                      value: "${classes.classLevel.toString()}.Sınıflar"),
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
                                  _showClassDetail(classes);
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.lightBlueAccent,
                                )),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  _editClass(classes);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.lightGreen,
                                )),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  _deleteClass(classes.id!);
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
                ],
              ),
            )
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

  void _showClassDetail(Classes classes) {
    _controller.showClassDetail(classes);
    final adminViewController = Get.put(AdminViewController());
    adminViewController.selectMenuItem(2);
    debugPrint(classes.toString());
  }

  void _editClass(Classes classes) {
    _controller.editClass(classes);
  }

  void _deleteClass(String classID) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText: "Silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        _controller.deleteClass(classID);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
