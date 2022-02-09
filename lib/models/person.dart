class Person {
  Person(this.id, this.name, this.lastName, this.age);

  final String? id;
  final String? name;
  final String? lastName;
  final int? age;

  getId() => id;

  getName() => name;

  getLastName() => lastName;

  getAge() => age;
}
