part of admin_message_view;

class AdminMessageContent extends GetView<AdminMessageController> {
  const AdminMessageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(controller.getText());
  }
}
