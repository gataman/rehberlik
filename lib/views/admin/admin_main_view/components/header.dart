part of admin_main_view;

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(AdminMainViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              onPressed: () {
                _controller.controlMenu();
              },
              icon: const Icon(Icons.menu),
            ),
          Column(
            children: const [
              Text(
                "Rehberlik Servisi",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              Text(
                "Yönetici Paneli",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          if (!Responsive.isMobile(context))
            /*
            const Expanded(
              child: SearchWidget(text: text, onChanged: onChanged, hintText: hintText),
            ),

             */
            const ProfileCard()
        ],
      ),
    );
  }
}
