class QueryMutation {
  dynamic addPerson(String id, String name, String lastName, int age) {
    return r"""
      mutation{
          addPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
            id
            name
            lastName
            age
          }
      }
    """;
  }

  dynamic getAll(){
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

  dynamic deletePerson(id){
    return r"""
      mutation{
        deletePerson(id: "$id"){
          id
        }
      } 
    """;
  }

  dynamic editPerson(String id, String name, String lastName, int age){
    return r"""
      mutation{
          editPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
            name
            lastName
          }
      }    
     """;
  }
}
