import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qgl_get_rewrite/pages/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GQL - GETX"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Get.defaultDialog();
              // controller.cleanList();
              // controller.fillList();
            },
            tooltip: "Insert new person",
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Person",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Obx(() => controller.isLoading == false
                ? ListView.builder(
                    itemCount: controller.listPerson.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: const Icon(Icons.icecream),
                          subtitle: controller.listPerson[index]
                                      .getLastName() !=
                                  null
                              ? Text(
                                  'Last Name: ${controller.listPerson[index].getLastName()}')
                              : const Text("Not Available"),
                          title: Text(
                            "net${controller.listPerson[index].getName()}",
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  )
                : const CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
