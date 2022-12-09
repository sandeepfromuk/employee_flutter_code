import 'package:employee/common/customtextfield.dart';
import 'package:employee/service/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AddEmployee extends StatefulWidget {
   AddEmployee({Key? key,required this.profile,required this.departmentName,required this.firstName,
    required this.lastname,required this.joiningDate,required this.pageName,required this.id}) : super(key: key);
   String? pageName,firstName,lastname,profile,departmentName,joiningDate;
   int? id;

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _addemp = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _joiningDateController = TextEditingController();
  bool _isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pageName=='Edit'){
      _idController.text=widget.id.toString();
      _firstNameController.text=widget.firstName!;
      _lastNameController.text=widget.lastname!;
      _profileController.text=widget.profile!;
      _departmentController.text=widget.departmentName!;
      _joiningDateController.text=widget.joiningDate!;
    }
  }

  void dispose() {
    super.dispose();
    _idController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _profileController.dispose();
    _departmentController.dispose();
    _joiningDateController.dispose();
  }

  //date picker code
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(DateTime.now().year - 100, 1),
    lastDate: DateTime(DateTime.now().year + 100, 1),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _joiningDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }
  @override
  Widget build(BuildContext context) {
    EmployeeService employeeService=EmployeeService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('${widget.pageName} Employee',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
         body:


         _isLoading?
             Center(child: CircularProgressIndicator())
             :SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  color: Colors.white54,
                  child: Form(
                    key: _addemp,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(

                          children: [
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Id',
                              controller: _idController,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                             hintText: 'FirstName',
                               controller: _firstNameController,
                       ),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'LastName',
                              controller: _lastNameController,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Department',
                              controller: _departmentController,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Profile',
                              controller: _profileController,

                            ),

                            SizedBox(height: 10),
                            TextFormField(
                              controller: _joiningDateController,
                              enabled: true,
                              onTap: () async {
                                _selectDate(context);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Joining Date',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black38,
                                      )),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black38,
                                      ))),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Enter the joining date';
                                }
                                return null;
                              },

                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: ()async{
                                  setState(() {
                                    _isLoading=true;
                                  });

                             if (_addemp.currentState!.validate()) {
                             if(widget.pageName=='Edit'){
                               await employeeService.update(int.parse(_idController.text),
                                   _firstNameController.text, _lastNameController.text, _departmentController.text,
                                   _profileController.text, _joiningDateController.text,context).then((value) {
                                     if(value==true)
                                       Navigator.pop(context,1);
                               });

                               }else{
                               await employeeService.addEmployee(int.parse(_idController.text), _firstNameController.text, _lastNameController.text, _departmentController.text, _profileController.text, _joiningDateController.text,context
                               ).then((value) {
                                 if(value==true){
                                   Navigator.pop(context,1);
                                   _idController.clear();
                                   _firstNameController.clear();
                                   _lastNameController.clear();
                                   _joiningDateController.clear();
                                   _departmentController.clear();
                                   _profileController.clear();
                                 }
                                 setState(() {
                                   _isLoading=false;
                                 });
                               });
                             }

                             }
                             }, child: Text('Submit'),
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                backgroundColor: Colors.deepPurple,
                              ),
                                ),

  ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
