import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qgl_get_rewrite/models/person.dart';
import 'package:qgl_get_rewrite/services/graphqlConf.dart';
import 'package:qgl_get_rewrite/services/queryMutation.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  List<Person> listPerson = <Person>[].obs;

  TextEditingController? txtId = TextEditingController();
  TextEditingController? txtName = TextEditingController();
  TextEditingController? txtLastName = TextEditingController();
  TextEditingController? txtAge = TextEditingController();

  var id = "";
  var name = "";
  var lastName = "";
  var age = "";

  var isLoading = false.obs;
  var isAdd = false.obs;
  var sending = false.obs;

  var selectedValue = "Natnael controller".obs;

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  @override
  void onInit() {
    fillList();
    txtId = TextEditingController();
    txtName = TextEditingController();
    txtLastName = TextEditingController();
    txtAge = TextEditingController();
    super.onInit();
  }

  void clearTextControllers() {
    txtId?.clear();
    txtName?.clear();
    txtLastName?.clear();
    txtAge?.clear();
  }

  void setSendingTrue() {
    sending(true);
  }

  void populateData(index) {
    listPerson[index].getId() != null
        ? txtId!.text = listPerson[index].getId()
        : null;
    listPerson[index].getName() != null
        ? txtName!.text = listPerson[index].getName()
        : null;
    listPerson[index].getLastName() != null
        ? txtLastName!.text = listPerson[index].getLastName()
        : null;
    listPerson[index].getAge() != null
        ? txtAge!.text = listPerson[index].getAge().toString()
        : null;
  }

  void fillList() async {
    isLoading(true);
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(queryMutation.getAll()),
      ),
    );
    if (!result.hasException) {
      for (var i = 0; i < result.data?["persons"].length; i++) {
        listPerson.add(
          Person(
            result.data?["persons"][i]["id"],
            result.data?["persons"][i]["name"],
            result.data?["persons"][i]["lastName"],
            result.data?["persons"][i]["age"],
          ),
        );
      }
      isLoading(false);
    }
  }

  void setSendingFalse() {
    sending(false);
  }

  void cleanList() async {
    listPerson.clear();
  }

  addPerson(context) async {
    if (txtId!.text.isNotEmpty &&
        txtName!.text.isNotEmpty &&
        txtLastName!.text.isNotEmpty &&
        txtAge!.text.isNotEmpty) {
      setSendingTrue();
      // print(int.parse(txtAge.text));
      GraphQLClient _client = graphQLConfiguration.clientToQuery();

      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(QueryMutation.addPerson),
          variables: <String, dynamic>{
            'id': txtId!.text,
            'name': txtName!.text,
            'lastName': txtLastName!.text,
            'age': int.parse(txtAge!.text)
          },
        ),
      );

      if (!result.hasException) {
        // print(result.data?["action"]["name"]);
        listPerson.add(Person(
            result.data?["action"]["id"],
            result.data?["action"]["name"],
            result.data?["action"]["lastName"],
            result.data?["action"]["age"]));

        clearTextControllers();

        setSendingFalse();
        Navigator.of(context).pop();

        Get.snackbar("Success", "You have Successfully Added the person",
            icon:
                const Icon(Icons.notification_add_rounded, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        print(result.exception.toString());
        // Get.snackbar("Error", result.exception.toString());
      }
    }
  }

  editPerson(context, index) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(QueryMutation.editPerson),
        variables: <String, dynamic>{
          'id': txtId!.text,
          'name': txtName!.text,
          'lastName': txtLastName!.text,
          'age': int.parse(txtAge!.text)
        },
      ),
    );
    if (!result.hasException) {
      Navigator.of(context).pop();
      cleanList();
      fillList();
      // listPerson[index].id = result.data?["action"]["id"];
      // listPerson[index].name = result.data?["action"]["name"];
      // listPerson[index].lastName = result.data?["action"]["lastName"];
      // listPerson[index].age = result.data?["action"]["age"];
      clearTextControllers();

      Get.snackbar("Success", "You have Successfully edited the person",
          icon: const Icon(Icons.notification_add_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      print(result.exception.toString());
    }
  }

  removePerson(index) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(QueryMutation.deletePerson),
        variables: <String, dynamic>{
          'id': listPerson[index].getId(),
        },
      ),
    );
    if (!result.hasException) {
      print(result.data);
      listPerson.removeAt(index);
      Get.snackbar("Success", "You have Successfully deleted the person",
          icon: const Icon(Icons.notification_add_rounded, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }
}
