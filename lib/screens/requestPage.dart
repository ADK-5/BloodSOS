// ignore_for_file: non_constant_identifier_names

import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:blood_donation/dtbase.dart';
import 'package:blood_donation/providers/requstCountProviders.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({Key? key}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm>
    with TickerProviderStateMixin {
  final _requestFormKey = GlobalKey<FormState>();
  late List<String> CitiesOnly = [];
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

  late String _requestedBG;
  late String _controllerRequestUnit;
  late String _controllerRequestCity;
  late String _controllerRequestState;
  late String _controllerRequestCountry;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _requestFormKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField(
                      validator: (bg) {
                        if (bg == null || bg.isEmpty) {
                          return "Select Required Blood Group";
                        }
                        return null;
                      },
                      decoration: TextFormFieldStyle.copyWith(
                        labelText: "Blood Group",
                      ),
                      items: blood_groups.map((reqBG) {
                        return DropdownMenuItem(
                            value: reqBG,
                            child: Text(
                              reqBG,
                              style: const TextStyle(color: Colors.blue),
                            ));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _requestedBG = val!;
                        });
                      }),
                ),
                GestureDetector(
                    onTap: () => context.read<Counter>().decrement(),
                    child: const CircularButton(
                      icon: CupertinoIcons.minus,
                    )),
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    _controllerRequestUnit = context.watch<Counter>().unit.toString(),
                    style: const TextStyle(fontSize: 30),
                  )),
                ),
                GestureDetector(
                  onTap: () => context.read<Counter>().increment(),
                  child: const CircularButton(
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CSCPicker(
              layout: Layout.vertical,
              disabledDropdownDecoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red, width: 3),
              ),
              showCities: true,
              showStates: true,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red, width: 3),
              ),
              defaultCountry: CscCountry.India,
              countryFilter: const [CscCountry.India],
              onStateChanged: (value) {
                setState(() {
                  _controllerRequestState = value ?? "";
                });
              },
              onCountryChanged: (value) {
                setState(() {
                  _controllerRequestCountry = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  _controllerRequestCity = value ?? "";
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm Request'),
                      content: Text(
                          'You have requested $_controllerRequestUnit units of $_requestedBG blood at $_controllerRequestCity,$_controllerRequestState'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await DB().createRequest(
                                req_blood_group: _requestedBG,
                                req_units: _controllerRequestUnit,
                                state: _controllerRequestState,
                                city: _controllerRequestCity);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Colors.red),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
                child: const Text("Submit Request"))
          ],
        ));
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
