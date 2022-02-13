class QueryMutation {
  // dynamic deletePerson(id) {
  //   return r"""
  //     mutation{
  //       deletePerson(id: "$id"){
  //         id
  //       }
  //     }
  //   """;
  // }

  // dynamic editPerson(String id, String name, String lastName, int age) {
  //   return r"""
  //     mutation{
  //         editPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
  //           name
  //           lastName
  //         }
  //     }
  //    """;
  // }

  // dynamic addPerson(String id, String name, String lastName, int age) {
  //   return r"""
  //     mutation{
  //         addPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
  //           id
  //           name
  //           lastName
  //           age
  //         }
  //     }
  //   """;
  // }

  static const String deletePerson = r'''
  mutation DeletePerson($id: ID!) {
    action: deletePerson(id: $id) {
      id
    }
  }
''';

  static const String editPerson = r'''
  mutation EditPerson($id: ID!, $name: String!, $lastName: String!, $age: Int!) {
    action: editPerson(id: $id, name: $name, lastName: $lastName, age: $age) {
      id
      name
      lastName
      age
    }
  }
''';

  static const String addPerson = r'''
  mutation AddPerson($id: ID!, $name: String!, $lastName: String!, $age: Int!) {
    action: addPerson(id: $id, name: $name, lastName: $lastName, age: $age) {
      id
      name
      lastName
      age
    }
  }
''';

  dynamic getAll() {
    return r""" 
      {
        persons{
          id
          name
          lastName
          age
        }
      }
    """;
  }
}
