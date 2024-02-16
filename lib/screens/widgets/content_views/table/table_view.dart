import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableView<R> extends StatelessWidget {
  const TableView(
      {super.key,
      required this.data,
      required this.getRow,
      required this.columnNames});
  final List<R> data;
  final Map<String, String> Function(R row) getRow;
  final List<String> columnNames;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: (data.length + 1) * 50 + 20,
        child: SfDataGridTheme(
            data: SfDataGridThemeData(
                headerColor: Colors.green.shade300,
                gridLineColor: const Color.fromARGB(255, 161, 158, 158)),
            child: SfDataGrid(
                verticalScrollPhysics: const BouncingScrollPhysics(),
                shrinkWrapColumns: false,
                columnWidthMode: ColumnWidthMode.fill,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: DataSource(data.map((e) => getRow(e)).toList()),
                columns: columnNames
                    .map<GridColumn>((e) => GridColumn(
                        columnName: e,
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Text(e))))
                    .toList())));
  }
}

class DataSource extends DataGridSource {
  DataSource(this.education) {
    _educationData = education
        .map<DataGridRow>((e) => DataGridRow(cells: () {
              List<DataGridCell<String>> cells = [];
              for (var i = 0; i < e.length; i++) {
                cells.add(DataGridCell<String>(
                    columnName: e.keys.elementAt(i),
                    value: e[e.keys.elementAt(i)]));
              }
              return cells;
            }()))
        .toList();
  }
  final List<Map<String, String>> education;
  List<DataGridRow> _educationData = [];

  @override
  List<DataGridRow> get rows => _educationData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 10),
        ),
      );
    }).toList());
  }
}
