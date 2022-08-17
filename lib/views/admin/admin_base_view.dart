import 'package:rehberlik/common/widgets/expand_button.dart';
import 'package:rehberlik/views/admin/admin_main_view/admin_main_view_imports.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';

abstract class AdminBaseView<T extends AdminBaseController> extends GetView<T> {
  const AdminBaseView({Key? key}) : super(key: key);

  Widget get firstView;
  Widget get secondView;

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context) ? _mobileContent() : _desktopContent();
  }

  Widget _desktopContent() {
    return SingleChildScrollView(
      child: Obx(() {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: firstView,
            ),
            if (!controller.isExpanded.value)
              const SizedBox(
                width: 4,
              ),
            ExpandButton(
              onPressed: () {
                controller.isExpanded.value = !controller.isExpanded.value;
              },
              isHorizontal: true,
              isExpanded: controller.isExpanded.value,
            ),
            if (!controller.isExpanded.value)
              Expanded(
                flex: 2,
                child: secondView,
              ),
            if (controller.isExpanded.value)
              const SizedBox(
                width: 8,
              ),
          ],
        );
      }),
    );
  }

  Widget _mobileContent() {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!controller.isExpanded.value) secondView,
            Center(
              child: ExpandButton(
                onPressed: () {
                  controller.isExpanded.value = !controller.isExpanded.value;
                },
                isHorizontal: false,
                isExpanded: controller.isExpanded.value,
              ),
            ),
            firstView,
          ],
        );
      }),
    );
  }
}
