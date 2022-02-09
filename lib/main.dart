import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qgl_get_rewrite/pages/home/home_binding.dart';
import 'package:qgl_get_rewrite/pages/home/home_view.dart';
import 'package:qgl_get_rewrite/services/graphqlConf.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() => runApp(
      GraphQLProvider(
        client: graphQLConfiguration.client,
        child: const CacheProvider(child: MyApp()),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const HomeView(), binding: HomeBinding() ),
      ],
    );
  }
}
