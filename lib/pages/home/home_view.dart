import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:qgl_get_rewrite/common/dialogue.dart';
import 'package:qgl_get_rewrite/pages/home/home_controller.dart';
import 'package:qgl_get_rewrite/services/graphqlConf.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

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
              Get.defaultDialog(
                title: "Add",
                content: controller.sending == false
                    ? AppDialogue()
                    : Container(
                        padding: const EdgeInsets.all(30),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                actions: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text("Add"),
                    onPressed: () {
                      controller.addPerson(context);
                    },
                  )
                ],
              );
              // controller.cleanList();
              // controller.fillList();
            },
            tooltip: "Insert new person",
          ),
        ],
      ),
      body: Stack(
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   child: const Text(
          //     "Person",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 10.0),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: Obx(() => controller.isLoading == false
                ? ListView.builder(
                    itemCount: controller.listPerson.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Slidable(
                          key: const ValueKey(0),

                          endActionPane:  ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context){
                                  controller.removePerson(index);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.icecream),
                            subtitle: controller.listPerson[index]
                                        .getLastName() !=
                                    null
                                ? Text(
                                    'Last Name: ${controller.listPerson[index].getLastName()}')
                                : const Text("Not Available"),
                            title: Text(controller.listPerson[index].getName()),
                            onTap: () {
                              controller.isAdd(false);
                              controller.populateData(index);

                              Get.defaultDialog(
                                title: "Edit",
                                barrierDismissible: false,
                                content: AppDialogue(),
                                actions: [
                                  TextButton(
                                      child: const Text("Close"),
                                      onPressed: () => {
                                            Navigator.of(context).pop(),
                                            controller.clearTextControllers(),
                                          }),
                                  TextButton(
                                    child: const Text("Edit"),
                                    onPressed: () {
                                      controller.editPerson(context, index);
                                    },
                                  )
                                ],
                              );
                            },
                          ),
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
