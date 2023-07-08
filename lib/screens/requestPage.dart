import 'package:blood_donation/commons/fieldStyle.dart';
import 'package:blood_donation/lists/states%20and%20cities.dart';
import 'package:blood_donation/providers/requstCountProviders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestForm extends StatefulWidget {
  RequestForm({Key? key}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _requestFormKey = GlobalKey<FormState>();

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
                      isExpanded: true,
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
                    child: const Circularbutton(
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
                    "${context.watch<Counter>().unit}",
                    style: TextStyle(fontSize: 30),
                  )),
                ),
                GestureDetector(
                  onTap: () => context.read<Counter>().increment(),
                  child: const Circularbutton(
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              decoration: TextFormFieldStyle.copyWith(labelText: "State"),
                items: states.map((selectedstate) {
                  return DropdownMenuItem(
                      value: selectedstate, child: Text(selectedstate));
                }).toList(),
                onChanged: (selectedstate) {
                  setState(() {
                    _controllerRequestState = selectedstate!;
                  });
                }),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(items: [], onChanged: (_) {}),
          ],
        ));
  }
}

class Circularbutton extends StatelessWidget {
  const Circularbutton({
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
