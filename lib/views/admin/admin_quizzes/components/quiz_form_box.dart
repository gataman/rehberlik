import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/views/admin/admin_quizzes/cubit/quiz_list_cubit.dart';

import '../../../../common/constants.dart';
import '../../../../common/custom_dialog.dart';
import '../../../../common/widgets/loading_button.dart';
import '../../../../core/init/locale_keys.g.dart';
import '../../../../core/widgets/buttons/app_cancel_form_button.dart';
import '../../../../core/widgets/containers/app_form_box_elements.dart';
import '../../../../core/widgets/text/app_menu_title.dart';
import '../../../../core/widgets/text_form_fields/app_outline_text_form_field.dart';
import '../../../../models/quiz.dart';

class QuizFormBox extends StatefulWidget {
  const QuizFormBox({Key? key}) : super(key: key);

  @override
  State<QuizFormBox> createState() => _QuizFormBoxState();
}

class _QuizFormBoxState extends State<QuizFormBox> {
  final _tfQuizTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _quizTitleFocusNode;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);
  Quiz? _quiz;

  @override
  void initState() {
    _quizTitleFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfQuizTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<QuizListCubit, QuizListState>(builder: (context, state) {
        _quiz = state is EditQuizState ? state.editQuiz : null;

        if (_quiz != null) {
          _quizTitleFocusNode.requestFocus();
          _tfQuizTitleController.text = _quiz!.quizTitle!;
        } else {
          _resetForm();
        }

        return Column(
          children: [
            _title(),
            AppFormBoxElements(formKey: _formKey, children: [
              _quizTitleInput(),
              _actionButtons(),
            ]),
          ],
        );
      }),
    );
  }

  void _resetForm() {
    _tfQuizTitleController.text = "";
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (_quiz != null)
          Expanded(
            child: AppCancelFormButton(
              onPressed: () {
                context.read<QuizListCubit>().editQuiz(quiz: null);
              },
            ),
          ),

        if (_quiz != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),

        Expanded(
          child: LoadingButton(
            text: _quiz == null ? LocaleKeys.actions_save.locale() : LocaleKeys.actions_update.locale(),
            loadingListener: buttonListener,
            onPressed: () {
              if (_quiz == null) {
                _saveQuiz();
              } else {
                _editQuiz(_quiz);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _quizTitleInput() {
    return AppOutlineTextFormField(
      isStyleDifferent: _quiz == null,
      validateText: 'Sınav Adı boş olamaz!',
      onFieldSubmitted: (value) {
        _saveQuiz();
      },
      focusNode: _quizTitleFocusNode,
      controller: _tfQuizTitleController,
      hintText: _quiz == null ? 'Sınav Adı' : _quiz?.quizTitle,
    );
  }

  Widget _title() {
    String title = _quiz == null ? 'Sınav Kaydet' : 'Sınav Düzenle';
    return AppMenuTitle(
      title: title,
      color: _quiz == null ? Colors.amber : infoColor,
    );
  }

  void _saveQuiz() {
    QuizListCubit cubit = context.read<QuizListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;

      final Quiz quiz = Quiz(quizTitle: _tfQuizTitleController.text, quizDate: DateTime.now());

      cubit.addQuiz(quiz).then((value) {
        _resetForm();
        buttonListener.value = false;
        CustomDialog.showSnackBar(
          message: 'Sınav başarıyla eklendi!',
          context: context,
          type: DialogType.success,
        );
      }, onError: (e) {
        buttonListener.value = false;
        CustomDialog.showSnackBar(
          message: LocaleKeys.alerts_error.locale([e.toString()]),
          context: context,
          type: DialogType.error,
        );
      });
    }
  }

  void _editQuiz(Quiz? quiz) {
    if (quiz != null) {
      quiz.quizTitle = _tfQuizTitleController.text;
    }
  }

  bool _checkFormElement() {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
