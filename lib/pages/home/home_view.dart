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
       centerTitle: true, actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              controller.fillList();
            },
            tooltip: "Insert new person",
          ),
        ],),
        
     body:  Stack(
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
            child: ListView.builder(
              itemCount: controller.listPerson.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "net${controller.listPerson[index].getName()}",
                  ),
                  onTap: () {
                   
                  },
                );
              },
            ),
          ),
        ],
      ),
     
   );
  }
  
}