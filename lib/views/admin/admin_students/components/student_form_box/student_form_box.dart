part of admin_students_view;

class StudentFormBox extends StatelessWidget {
  const StudentFormBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultBoxDecoration,
      child: Padding(
          padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
          child: BlocBuilder<ClassListCubit, ClassListState>(builder: (context, classState) {
            if (classState is ClassListLoadedState) {
              final List<StudentWithClass>? classesList = classState.studentWithClassList;
              return Column(
                children: [
                  _title(),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  _getDropDownMenu(classesList),
                ],
              );
            } else {
              return const SizedBox(height: minimumBoxHeight, child: DefaultCircularProgress());
            }
          })),
    );
  }

  Widget _title() {
    return AppMenuTitle(
      title: LocaleKeys.students_classSelectTitle.locale(),
    );
  }

  Widget _getDropDownMenu(List<StudentWithClass>? classesList) {
    if (classesList != null && classesList.isNotEmpty) {
      return BlocBuilder<StudentListCubit, StudentListState>(builder: (context, state) {
        final selectedIndex = state is SelectedIndexState ? state.selectedIndex : 0;
        return _buildDropdownButtonFormField(classesList, selectedIndex, context);
      });
    } else {
      return const AppEmptyWarningText(text: "Sınıf listesi yüklenemedi!");
    }
  }

  DropdownButtonFormField<StudentWithClass> _buildDropdownButtonFormField(
      List<StudentWithClass> classesList, int selectedIndex, BuildContext context) {
    return DropdownButtonFormField<StudentWithClass>(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: TextStyle(color: Colors.white30),
        fillColor: darkSecondaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      value: classesList[selectedIndex],
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (StudentWithClass? newValue) {
        if (newValue != null) {
          context.read<StudentListCubit>().selectIndex(selectedIndex: classesList.indexOf(newValue));
          //valueChanged(newValue.classLevel);
          //_selectedCategory = newValue.classLevel;
        }
      },
      items: classesList.map<DropdownMenuItem<StudentWithClass>>((StudentWithClass value) {
        return DropdownMenuItem<StudentWithClass>(
          value: value,
          child: Text(
            value.classes.className!,
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
    );
  }
}
