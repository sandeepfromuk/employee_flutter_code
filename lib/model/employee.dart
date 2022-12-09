class EmployeeModel {

  static List<Employee> employees=[
  Employee(
        id: 1,
        firstName: "sandeep",
        lastName: "singh",
        profile: "developer",
        department: "java",
        joiningDate: "2022-12-11",

    ),
    Employee(
      id: 2,
      firstName: "sam ",
      lastName: "bohra",
      profile: "developer",
      department: "flutter",
      joiningDate: "2016-01-01",

    )


  ];


}


class Employee {
  Employee({
    this.id,
    this.firstName,
    this.lastName,
   this. profile,
    this.department,
    this.joiningDate,
  });

  int? id;
  String ?firstName;
  String? lastName;
  String? profile;
  String ?department;
  String ?joiningDate;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    profile: json["profile"],
    department: json["department"],
    joiningDate:  json["joiningDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "profile": profile,
    "department": department,
    "joiningDate": joiningDate,
  };
}