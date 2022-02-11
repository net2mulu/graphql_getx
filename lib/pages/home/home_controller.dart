import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qgl_get_rewrite/models/person.dart';
import 'package:qgl_get_rewrite/services/graphqlConf.dart';
import 'package:qgl_get_rewrite/services/queryMutation.dart';

class HomeController extends GetxController {
  List<Person> listPerson = <Person>[].obs;
  var isLoading = false.obs;

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  @override
  void onInit() {
    fillList();
    super.onInit();
  }

  void cleanList() async {
    listPerson.clear();
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
}
