import 'package:flutter/material.dart';
import '../../../common/extensions.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SfDataGridIcon extends StatelessWidget {
  const SfDataGridIcon({Key? key, required this.child, required this.dataGridSource}) : super(key: key);
  final Widget child;
  final DataGridSource dataGridSource;

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
        data: SfDataGridThemeData(
            sortIcon: _setIcon(),
            filterIcon: const Icon(
              Icons.search,
              size: 14,
            )),
        child: child);
  }

  _setIcon() {
    return Builder(
      builder: (context) {
        Widget? icon;
        String columnName = '';
        context.visitAncestorElements((element) {
          if (element is GridHeaderCellElement) {
            columnName = element.column.columnName;
          }
          return true;
        });
        var column = dataGridSource.sortedColumns.findOrNull((element) => element.name == columnName);
        if (column != null) {
          if (column.sortDirection == DataGridSortDirection.ascending) {
            icon = const Icon(Icons.arrow_circle_up_rounded, size: 14);
          } else if (column.sortDirection == DataGridSortDirection.descending) {
            icon = const Icon(Icons.arrow_circle_down_rounded, size: 14);
          }
        }
        return icon ??
            const Icon(
              Icons.sort_outlined,
              size: .1,
            );
      },
    );
  }
}
