part of admin_uploads_view;

class ExpansionStudentList extends StatefulWidget {
  final Map<String, List<Student>> data;

  const ExpansionStudentList({Key? key, required this.data}) : super(key: key);

  @override
  State<ExpansionStudentList> createState() => _ExpansionStudentListState();
}

class _ExpansionStudentListState extends State<ExpansionStudentList> {
  var classesPanelList = <ExpansionPanel>[];

  var firstCreate = true;
  List<bool> _isExpandedList = [];

  @override
  Widget build(BuildContext context) {
    return _setDataFromExcel(widget.data);
  }

  Widget _setDataFromExcel(Map<String, List<Student>>? data) {
    var classesPanelList = <ExpansionPanel>[];

    if (data != null) {
      if (firstCreate) {
        _isExpandedList = List.generate(data.length, (_) => false);
        firstCreate = false;
      }

      var i = 0;
      data.forEach((key, studentList) {
        var classExpansionPanel = ExpansionPanel(
            backgroundColor: secondaryColor,
            headerBuilder: (context, isOpen) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Sınıf: ${key.toString()}",
                  style: defaultTitleStyle,
                ),
              );
            },
            isExpanded: _isExpandedList[i],
            canTapOnHeader: true,
            body: _setStudentListDataTable(studentList));
        classesPanelList.add(classExpansionPanel);
        i++;
      });

      return Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          border: Border.all(color: Colors.white10),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionPanelList(
            dividerColor: Colors.white10,
            elevation: 0,
            children: classesPanelList,
            expansionCallback: (i, isOpen) =>
                setState(() => _isExpandedList[i] = !isOpen),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _setStudentListDataTable(List<Student> studentList) {
    final columnList = <DataColumn>[
      const DataColumn(label: Text("No", style: studentListSmallStyle)),
      const DataColumn(label: Text("Adı Soyadı", style: studentListSmallStyle)),
      const DataColumn(label: Text("Sınıfı", style: studentListSmallStyle)),
      const DataColumn(label: Text("Baba Adı", style: studentListSmallStyle)),
      const DataColumn(label: Text("Anne Adı", style: studentListSmallStyle)),
      const DataColumn(label: Text("Cinsiyet", style: studentListSmallStyle)),
      const DataColumn(
          label: Text("Doğum Tarihi", style: studentListSmallStyle)),
    ];

    final rowList = <DataRow>[];
    for (var student in studentList) {
      final studentRow = DataRow(cells: <DataCell>[
        DataCell(Text(
          "${student.studentNumber}",
          style: studentListSmallStyle,
        )),
        DataCell(
          Text(student.studentName != null ? student.studentName! : "",
              style: studentListSmallStyle),
        ),
        DataCell(
          Text(student.className != null ? student.className! : "",
              style: studentListSmallStyle),
        ),
        DataCell(
          Text(student.fatherName != null ? student.fatherName! : "",
              style: studentListSmallStyle),
        ),
        DataCell(
          Text(student.motherName != null ? student.motherName! : "",
              style: studentListSmallStyle),
        ),
        DataCell(
          Text(student.gender != null ? student.gender! : "",
              style: studentListSmallStyle),
        ),
        DataCell(
          Text(student.birthDay != null ? student.birthDay! : "",
              style: studentListSmallStyle),
        ),
      ]);

      rowList.add(studentRow);
    }

    final dataTable = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: columnList, rows: rowList),
    );
    return dataTable;
  }
}
