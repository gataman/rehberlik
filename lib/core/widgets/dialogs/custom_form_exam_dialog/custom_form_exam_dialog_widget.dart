import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/common/helper/trial_exam_graph/trial_exam_graph.dart';
import 'package:rehberlik/core/widgets/buttons/form_cancel_button.dart';
import 'package:rehberlik/core/widgets/buttons/form_save_button.dart';
import 'package:rehberlik/core/widgets/dialogs/custom_form_exam_dialog/cubit/form_exam_cubit.dart';

import '../../../../common/constants.dart';
import '../../../../models/lesson.dart';
import '../../../../models/trial_exam_result.dart';
import '../../../../responsive.dart';

class CustomFormExamDialogWidget extends StatefulWidget {
  const CustomFormExamDialogWidget({Key? key, required this.child, required this.examResult}) : super(key: key);
  final Widget child;
  final TrialExamResult examResult;
  //final BuildContext context;

  @override
  State<CustomFormExamDialogWidget> createState() => _CustomFormExamDialogWidgetState();
}

class _CustomFormExamDialogWidgetState extends State<CustomFormExamDialogWidget> {
  final double _radius = 10;

  late final TextEditingController _txtTurDog;
  late final TextEditingController _txtTurYan;
  late final TextEditingController _txtSosDog;
  late final TextEditingController _txtSosYan;
  late final TextEditingController _txtDinDog;
  late final TextEditingController _txtDinYan;
  late final TextEditingController _txtIngDog;
  late final TextEditingController _txtIngYan;
  late final TextEditingController _txtMatDog;
  late final TextEditingController _txtMatYan;
  late final TextEditingController _txtFenDog;
  late final TextEditingController _txtFenYan;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _init();

    super.initState();
  }

  // @override
  // void dispose() {
  //   _txtTurDog.dispose();
  //   _txtTurYan.dispose();
  //   _txtSosDog.dispose();
  //   _txtSosYan.dispose();
  //   _txtDinDog.dispose();
  //   _txtDinYan.dispose();
  //   _txtIngDog.dispose();
  //   _txtIngYan.dispose();
  //   _txtMatDog.dispose();
  //   _txtMatYan.dispose();
  //   _txtFenDog.dispose();
  //   _txtFenYan.dispose();
  //   super.dispose();
  // }

  void _init() {
    _txtTurDog = TextEditingController();
    _txtTurYan = TextEditingController();
    _txtSosDog = TextEditingController();
    _txtSosYan = TextEditingController();
    _txtDinDog = TextEditingController();
    _txtDinYan = TextEditingController();
    _txtIngDog = TextEditingController();
    _txtIngYan = TextEditingController();
    _txtMatDog = TextEditingController();
    _txtMatYan = TextEditingController();
    _txtFenDog = TextEditingController();
    _txtFenYan = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDialog(context),
      child: widget.child,
    );
  }

  _showDialog(BuildContext context) {
    double width = Responsive.dialogWidth(context);
    double height = Responsive.dialogHeight(context);
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
            //contentPadding: const EdgeInsets.all(defaultPadding),
            actionsPadding: const EdgeInsets.all(defaultPadding),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.all(Radius.circular(_radius))),
            titlePadding: EdgeInsets.zero,
            title: Center(
              child: BlocBuilder<FormExamCubit, FormExamState>(
                builder: (context, state) {
                  if (state.errorMessage != null) {
                    return Stack(
                      children: [
                        _showErrorMessage(state.errorMessage!),
                        Align(
                          alignment: Alignment.topRight,
                          child: _closeButton(dialogContext, context, state.errorMessage),
                        ),
                      ],
                    );
                  } else {
                    return Align(
                      alignment: Alignment.topRight,
                      child: _closeButton(dialogContext, context, null),
                    );
                  }
                },
              ),
            ),
            content: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Table(
                        //columnWidths: const {0: FlexColumnWidth(2)},
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        // border: TableBorder.all(color: Theme.of(context).dividerColor),
                        children: [_tableTitles(context), ..._tableStudentData(context)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              FormCancelButton(
                onConfirm: () {},
              ),
              FormSaveButton(
                onConfirm: () {
                  _saveExamResult(dialogContext);
                },
              )
            ]);
      },
    );
  }

  Widget _showErrorMessage(String errorMessage) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        border: Border.all(color: Colors.white10),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ));

  IconButton _closeButton(BuildContext ctx, BuildContext context, String? errorMessage) {
    return IconButton(
        onPressed: () {
          if (errorMessage != null) {
            context.read<FormExamCubit>().resetErrorState();
          } else {
            Navigator.of(ctx).pop();
          }
        },
        icon: Icon(
          Icons.cancel,
          color: Theme.of(context).colorScheme.primary,
        ));
  }

  // List<TableRow> _getFormElements() {
  //   final elementWidgetList = <TableRow>[];

  //   elementWidgetList.add(_titleRow())
  // }

  TableRow _tableTitles(BuildContext context) {
    return TableRow(children: [
      _tableLabelTitle(context, 'Dersler'),
      _tableTitleValue(context, 'Doğru'),
      _tableTitleValue(context, 'Yanlış')
    ]);
  }

  Widget _tableLabelTitle(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _tableTitleValue(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  List<TableRow> _tableStudentData(BuildContext context) {
    final examResult = widget.examResult;
    final List<TableRow> tableRowList = [];

    tableRowList.add(TableRow(children: [
      _tableLabelValue(context, 'Türkçe'),
      _tableValues(context, examResult.turDog.toString(), _txtTurDog),
      _tableValues(context, examResult.turYan.toString(), _txtTurYan),
    ]));

    tableRowList.add(TableRow(children: [
      _tableLabelValue(context, 'Sosyal'),
      _tableValues(context, examResult.sosDog.toString(), _txtSosDog),
      _tableValues(context, examResult.sosYan.toString(), _txtSosYan),
    ]));

    tableRowList.add(TableRow(children: [
      _tableLabelValue(context, 'Din'),
      _tableValues(context, examResult.dinDog.toString(), _txtDinDog),
      _tableValues(context, examResult.dinYan.toString(), _txtDinYan),
    ]));

    tableRowList.add(TableRow(children: [
      _tableLabelValue(context, 'İngilizce'),
      _tableValues(context, examResult.ingDog.toString(), _txtIngDog),
      _tableValues(context, examResult.ingYan.toString(), _txtIngYan),
    ]));

    tableRowList.add(TableRow(children: [
      _tableLabelValue(context, 'Matematik'),
      _tableValues(context, examResult.matDog.toString(), _txtMatDog),
      _tableValues(context, examResult.matYan.toString(), _txtMatYan),
    ]));

    tableRowList.add(TableRow(children: [
      _tableLabelValue(context, 'Fen Bilimleri'),
      _tableValues(context, examResult.fenDog.toString(), _txtFenDog),
      _tableValues(context, examResult.fenYan.toString(), _txtFenYan),
    ]));

    return tableRowList;
  }

  Widget _tableLabelValue(BuildContext context, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          value,
          style: Theme.of(context).textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _tableValues(BuildContext context, String value, TextEditingController controller) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: _getFormField(label: value, value: value, controller: controller),
        ),
      );

  Widget _getFormField({required String label, required String value, required TextEditingController controller}) {
    controller.text = value;
    return TextFormField(
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return 'Değerler boş olamaz';
        }
        return null;
      },
      //onFieldSubmitted: onFieldSubmitted,
      //focusNode: focusNode,
      textInputAction: TextInputAction.go,
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        //hintText: label,
        errorStyle: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
        isDense: false,
        errorMaxLines: 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  void _saveExamResult(BuildContext dialogContext) {
    final turDog = _txtTurDog.text;
    final turYan = _txtTurYan.text;
    final sosDog = _txtSosDog.text;
    final sosYan = _txtSosYan.text;
    final dinDog = _txtDinDog.text;
    final dinYan = _txtDinYan.text;
    final ingDog = _txtIngDog.text;
    final ingYan = _txtIngYan.text;
    final matDog = _txtMatDog.text;
    final matYan = _txtMatYan.text;
    final fenDog = _txtFenDog.text;
    final fenYan = _txtFenYan.text;

    final Map<LessonCode, dynamic> map = {
      LessonCode.tur: {'dog': turDog, 'yan': turYan, 'type': LessonType.twenty},
      LessonCode.sos: {'dog': sosDog, 'yan': sosYan, 'type': LessonType.ten},
      LessonCode.din: {'dog': dinDog, 'yan': dinYan, 'type': LessonType.ten},
      LessonCode.ing: {'dog': ingDog, 'yan': ingYan, 'type': LessonType.ten},
      LessonCode.mat: {'dog': matDog, 'yan': matYan, 'type': LessonType.twenty},
      LessonCode.fen: {'dog': fenDog, 'yan': fenYan, 'type': LessonType.twenty},
    };

    context.read<FormExamCubit>().checkExamResults(examMap: map);
  }
}
