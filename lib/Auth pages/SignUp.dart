// ignore_for_file: file_names, non_constant_identifier_names

import 'package:blood_donation/auth.dart';
import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onLogin;
  const SignupPage({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDOB = TextEditingController();
  final TextEditingController _controllerPhNo = TextEditingController();
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
        title: const Text("Sign Up"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _controllerName,
                decoration: TextFormFieldStyle.copyWith(
                  labelText: "Name",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return "Please enter a  valid email";
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
                validator: (val) {
                  if (val == null || val.isEmpty || val.length < 8) {
                    return 'Password requires at-least 8 characters';
                  }
                  return null;
                },
                controller: _controllerPassword,
                decoration: TextFormFieldStyle.copyWith(labelText: "Password"),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
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
                    BloodGroup=UserBG!;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _controllercity,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await Auth().createUserwithEmailandPassword(
                          email: _controllerEmail.text,
                          password: _controllerPassword.text);
                      var value = Auth().currentUser!.uid;
                      await DB().createUser(
                          documentID: value,
                          name: _controllerName.text.trim(),
                          phoneNo: _controllerPhNo.text.trim(),
                          dateOfBirth: _controllerDOB.text.trim());
                    }
                  },
                  child: const Text("Sign Up")),
              const SizedBox(
                height: 10,
              ),
              const Text("Already have an account?"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: widget.onLogin, child: const Text("Sign In"))
            ],
          ),
        ),
      ),
    );
  }
}
