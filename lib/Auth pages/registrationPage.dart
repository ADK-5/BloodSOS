import 'package:blood_donation/Auth%20pages/WidgetTree.dart';
import 'package:blood_donation/providers/newUserCheckProvider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/rickRolled.dart';
import 'package:provider/provider.dart';
import '../auth.dart';
import '../commons/fieldStyle.dart';
import '../dtbase.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  void printer(String s)  {
    print(s);
 }
 // late final fcmToken;
  @override
  // void initState() async  {
  //   // TODO: implement initState
  //   super.initState();
  //   final Token = await FirebaseMessaging.instance.getToken();
  //   setState(() {
  //     fcmToken=Token;
  //   });
  //   printer(fcmToken);
  // }
  final _formkey = GlobalKey<FormState>();
  var id = Auth().currentUser?.uid;
  var phn = Auth().currentUser?.phoneNumber;

  final TextEditingController _controllerEmail =
      (Auth().currentUser?.email == null)
          ? TextEditingController()
          : TextEditingController(text: Auth().currentUser?.email);
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDOB = TextEditingController();
  final TextEditingController _controllerPhNo =
      (Auth().currentUser?.phoneNumber == null)
          ? TextEditingController()
          : TextEditingController(text: Auth().currentUser?.phoneNumber);
  final TextEditingController _controllercity = TextEditingController();
  final TextEditingController _controllerstate = TextEditingController();
  late String BloodGroup;

  final List<String> blood_groups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  DateTime validDate = DateTime.now().subtract(const Duration(days: 6200));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Page"),
        actions: [
          IconButton(
              onPressed: () {
                Auth().signOut();
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return "Please enter a Name of atleast 3 Letters";
                  }
                },
                controller: _controllerName,
                decoration: TextFormFieldStyle.copyWith(
                  labelText: "Name",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                enabled: Auth().currentUser?.email == null,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                controller: _controllerEmail,
                decoration: TextFormFieldStyle.copyWith(
                  labelText: "Email",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                enabled: (phn == null || phn!.isEmpty),
                controller: _controllerPhNo,
                validator: (phoneNo) {
                  if (phoneNo == null || phoneNo.length != 10) {
                    return "Phone Number must have 10 digits";
                  }
                  return null;
                },
                decoration:
                    TextFormFieldStyle.copyWith(labelText: "Phone Number"),
              ),
              const SizedBox(
                height: 15,
              ),
              DateTimePicker(
                initialDate: validDate,
                type: DateTimePickerType.date,
                controller: _controllerDOB,
                decoration:
                    TextFormFieldStyle.copyWith(labelText: "Date of Birth"),
                dateMask: 'dd/MM/yyyy',
                firstDate: DateTime(1950),
                lastDate: validDate,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                items: blood_groups.map((bg) {
                  return DropdownMenuItem(value: bg, child: Text(bg));
                }).toList(),
                decoration:
                    TextFormFieldStyle.copyWith(labelText: "Blood Group"),
                onChanged: (UserBG) {
                  setState(() {
                    BloodGroup = UserBG!;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              // TextFormField(
              //   controller: _controllercity,
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      // setState(() async {
                      //   fcmToken=await FirebaseMessaging.instance.getToken();
                      //   print(fcmToken);
                      // });
                      // print("id: $id");
                      await DB()
                          .createUser(
                            // documentID: id!,
                            name: _controllerName.text.trim(),
                            phoneNo: _controllerPhNo.text.trim(),
                            dateOfBirth: _controllerDOB.text.trim(),
                            city: _controllercity.text.trim(),
                            state: _controllerstate.text.trim(),
                            blood_group: BloodGroup,
                          )
                          .whenComplete(() => context
                              .read<NewUserChecker>()
                              .toggleUserUniqueness());
                    }
                  },
                  child: const Text("Register")),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => RickRolled()));
              //     },
              //     child: const Text("Mujhe Mat Dabao"))
            ],
          ),
        ),
      ),
    );
  }
}
