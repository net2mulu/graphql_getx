import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qgl_get_rewrite/pages/home/home_controller.dart';

class AppDialogue extends StatelessWidget {
  AppDialogue({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Stack(
            children: [
              Container(
                child: TextField(
                  controller: controller.txtId,
                  maxLength: 5,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    labelText: "ID",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 80.0),
                child: TextField(
                  controller: controller.txtName,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.text_format),
                    labelText: "Name",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 160.0),
                child: TextField(
                  controller: controller.txtLastName,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.text_rotate_vertical),
                    labelText: "Last name",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 240.0),
                child: TextField(
                  controller: controller.txtAge,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Age", icon: Icon(Icons.calendar_today)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
