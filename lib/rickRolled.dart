import 'package:flutter/material.dart';

class RickRolled extends StatelessWidget {
  const RickRolled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('assets/images/maxresdefault.jpg'),
        ),
      ),
    );
  }
}
