import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';
import 'package:rehberlik/responsive.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  final _controller = Get.put(AdminViewController());

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
            const Expanded(
              child: SearchField(),
            ),
          const ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "${imagesSrc}profile.jpeg",
              ),
            ),
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Gürcan Ataman"),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Öğrenci Arama",
          hintStyle: const TextStyle(color: Colors.white30),
          fillColor: secondaryColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: SvgPicture.asset("${iconsSrc}search.svg"),
              height: 20,
              width: 40,
            ),
          )),
    );
  }
}
