import 'dart:convert';
import 'package:employee/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String url = 'http://192.168.1.46:8080';
class EmployeeService  {

  //get all employee
   Future<List<Employee>>  getEmployee() async {
        List<Employee> productList = [];
        try {final response = await http
         .get(Uri.parse('$url/employee'),
          headers: {
          'Content-Type': 'application/json',
          });
     print('$url/employee');
     print(response.body);
        if (response.statusCode == 200) {
             //print(response.body);
             List resultData=jsonDecode(response.body);
              productList= resultData.map<Employee>((e) => Employee.fromJson(e)).toList();

              }
    }
     catch (e) {
      print(e);
      //print('sandeep');
  }
     return productList;
      //
    }



    //add employee

   Future<bool> addEmployee(int id,String firstName,String lastname,String department,String profile,String joiningDate,BuildContext context) async {
     Map<String, dynamic> jsonMap = {
       "id": id,"firstName": firstName,"lastName": lastname,"department": department,"profile": profile,"joiningDate": joiningDate
     };
     String jsonbody = json.encode(jsonMap);
     try {
       final response =
       await http
           .post(Uri.parse('$url/employee'),
           headers: {
             'Content-Type': 'application/json'},
           body:jsonbody
       );
       if(response.statusCode==200){

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:  Text("User is created sucessfully!!!.",style: TextStyle(color: Colors.blue),),

          ));
          return true;
       }
       else{

             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content:  Text("Something Went Wrong!!!.",style: TextStyle(color: Colors.blue),),
             ));
           return false;

       }
     } catch (exception) {
       print('catch block ${exception}');

         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           //content: "Buying not supported yet.".text.make(),
           content:  Text("Network Error!!!.",style: TextStyle(color: Colors.blue),),

         ));
       return false;
     }
   }

   //update employee
   Future<bool> update(int id,String firstName,String lastname,String department,String profile,String joiningDate,BuildContext context) async {
     Map<String, dynamic> jsonMap = {
       "id": id,"firstName": firstName,"lastName": lastname,"department": department,"profile": profile,"joiningDate": joiningDate
     };
     String jsonbody = json.encode(jsonMap);
     try {
        final response =
        await http
           .put(Uri.parse('$url/employee'),
            headers: {
             'Content-Type': 'application/json'},
            body:jsonbody
          );
       if(response.statusCode==200){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:  Text("User updated sucessfully!!!.",style: TextStyle(color: Colors.blue),),
            ));
            return true;
       }
       else{

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:  Text("Something Went Wrong!!!.",style: TextStyle(color: Colors.blue),),
            ));
         return false;
       }
     }
     catch (exception) {
           //print('catch block ${exception}');
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content:  Text("Network Error!!!.",style: TextStyle(color: Colors.blue),),
           ));
        return false;
     }
   }


   //delete employee
   Future<String> delete(int id ,BuildContext context) async {
     try {
        final response =
        await http.delete(Uri.parse('$url/employee/$id'),
          headers: {
           'Content-Type': 'application/json'},
       );
        if(response.statusCode==200){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content:  Text("Employee delete successfully !!!.",style: TextStyle(color: Colors.blue),),

         ));
         return 'yes';

       }
       else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content:  Text("Employee delete successfully !!!.",style: TextStyle(color: Colors.blue),),

         ));
         return 'no';

       }
     }
     catch (exception) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:  Text("Network Error!!!.",style: TextStyle(color: Colors.blue
           )),
       ),);
       return 'no';
     }
   }

}
