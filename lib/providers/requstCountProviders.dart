// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _count=1;
  int get unit =>_count;

  void increment(){
    if(_count<10) _count++;
    notifyListeners();
  }
  void decrement(){
    if(_count>1) _count--;
    notifyListeners();
  }
}