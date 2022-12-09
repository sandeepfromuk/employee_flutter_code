import 'package:employee/pages/addemployee.dart';
import 'package:employee/model/employee.dart';
import 'package:employee/service/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:employee/common/custom_text.dart';
String url = 'http://192.168.0.143:8080';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


 class _MyHomePageState extends State<MyHomePage> {
   var size,height,width;


  @override
  EmployeeService employeeService= EmployeeService();
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
          onPressed: () async{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(
               id:null ,profile: '',firstName: '',pageName: 'Add',lastname: '',joiningDate: '',departmentName: '',
             ))
             ).then((
                 value) async{
               if(value==1){

                 await refreshPage();

               }
             });
            


          },
        ),

          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title :Text('Employee Detatil',style: TextStyle(fontSize:27,color: Colors.white,fontWeight: FontWeight.bold)),

          ),

      body: RefreshIndicator(
            key: refreshkey,
        onRefresh: () async {

          await refreshPage();
        },
        child: ListView.builder(
          // shrinkWrap: true,
            itemCount: EmployeeModel.employees.length ,//EmployeeModel.employees.length,
            itemBuilder: (context, index){
            final getemp = EmployeeModel.employees[index];
            var a= EmployeeModel.employees[index].joiningDate;
            final dateFormat = DateFormat('dd-MM-yyyy');
            var b =DateTime.now();
            var c =DateTime.parse(a!);
            var subd=b.difference(c);
            var differenceInYears = (subd.inDays/365).floor();
            bool year=false;
            if(differenceInYears>=5){
              year=true;
            }


              return Card(

               color:differenceInYears>=5? Colors.green:Colors.white,

                //shape: StadiumBorder(),

                shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15.0), //<-- SEE HERE
                  ),
                elevation: 10,
                child:
                  Container(
                    width: width,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///1st
                        Row(
                          children: [
                            Expanded(
                              child: Row(children: [
                                    CustomText(text: 'Name:- ', fontWeight: FontWeight.w500),
                                    CustomText(text: "${getemp.firstName??''}  ${getemp.lastName??''}", fontWeight: FontWeight.w300,),
                                  ],),
                            ),
                            PopupMenuButton(

                                color: Colors.grey,
                                child: Icon(Icons.more_vert),
                                onSelected: (value) {
                                  print(value);
                                  // if value 1 show dialog
                                  if (value == 1) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee(
                                      departmentName: getemp.department,joiningDate: getemp.joiningDate,
                                      firstName:getemp.firstName ,profile:getemp.profile ,lastname: getemp.lastName,
                                      pageName: 'Edit',id: getemp.id,

                                    ))
                                    ).then((value) async{
                                      if(value==1){
                                        await refreshPage();
                                      }
                                    });
                                    // employeeService.update();
                                    // if value 2 show dialog
                                  } else if (value == 2) {
                                    print('inside delete');
                                   showDialog
                                     (context: context,
                                       builder: (_)=> AlertDialog(
                                         title: Text('Delete Employee'),
                                         content: Text('Are you sure to delete user?'),
                                         actions: [
                                           TextButton(
                                             onPressed: () async{
                                               Navigator.of(context).pop();
                                              await  employeeService.delete(getemp.id!,context).then((value) async{
                                                if(value=='yes'){
                                                  await refreshPage();

                                                }
                                              });
                                             },
                                             child: Text('YES', style: TextStyle(color: Colors.black),),
                                           ),
                                           TextButton(
                                             onPressed: () {
                                               Navigator.of(context).pop();
                                             },
                                             child: Text('NO', style: TextStyle(color: Colors.black),),
                                           ),
                                         ],
                                       )
                                     );
                                  }
                                },
                                itemBuilder:(context) => [
                                  PopupMenuItem(
                                    child: Text("Edit"),
                                    value: 1,

                                  ),
                                  PopupMenuItem(
                                    child: Text("Delete"),
                                    value: 2,
                                  ),

                                ]
                            )
                          ],
                        ),


                   ///2nd line
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              CustomText(text: 'Department:- ', fontWeight: FontWeight.w500),
                              CustomText(text: getemp.department??'', fontWeight: FontWeight.w300,),
                            ],),
                          ],
                        ),

                        ///3nn
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              CustomText(text: 'Profile:- ', fontWeight: FontWeight.w500),
                              CustomText(text: getemp.profile??'', fontWeight: FontWeight.w300,),
                            ],),
                          ],
                        ),
                        ///4th
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              CustomText(text: 'JoiningDate :- ', fontWeight: FontWeight.w500),
                              CustomText(text: getemp.joiningDate??'', fontWeight: FontWeight.w300,),
                            ],),
                            Row(children: [
                              CustomText(text: 'YearOfJoin :- ', fontWeight: FontWeight.w500),
                              CustomText(text: differenceInYears.toString(), fontWeight: FontWeight.w300,),
                            ],),

                          ],
                        ),
///mm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [


                          ],
                        ),
                      ],
                  )
                  )
              );

            }
        ),
      )
      ),
    );


}

  Future<void> refreshPage() async{
    List<Employee> employeeData=await employeeService.getEmployee();
    if(employeeData.isNotEmpty) {
      EmployeeModel.employees.clear();
      employeeData.forEach((element) {
        EmployeeModel.employees.add(element);
      }
      );
    }

    setState(() {

    });
  }
}
