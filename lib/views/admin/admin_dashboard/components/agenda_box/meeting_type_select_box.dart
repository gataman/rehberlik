part of admin_dashboard_view;

class MeetingTypeSelectBox extends StatelessWidget {
  final ValueChanged<int> onChanged;

  const MeetingTypeSelectBox({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: const TextStyle(color: Colors.white30),
        fillColor: darkSecondaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      value: meetingTypeList[0],
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(meetingTypeList.indexOf(newValue));
        }
      },
      items: meetingTypeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
    );
  }
}
