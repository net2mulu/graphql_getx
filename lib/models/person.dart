class Person {
  Person(this.id, this.name, this.lastName, this.age);

  late String? id;
  late String? name;
  late String? lastName;
  late int? age;

  getId() => id;

  getName() => name;

  getLastName() => lastName;

  getAge() => age;
}
