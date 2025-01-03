import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:go_do/views/tabs/categories.dart';
import 'package:go_do/views/tabs/home.dart';
import 'package:go_do/views/tabs/add_option.dart';

class NavigationModel extends BaseViewModel {

  int currentIndex = 1;

  final tabs = [
    const CategoriesPage(),
    const HomePage(),
    const AddOptionPage()
  ];

  final items = [
    const Icon(Icons.task,size: 30),
    const Icon(Icons.home,size: 30),
    const Icon(Icons.add,size: 30)
  ];

  void setCurrentTab(int index){
    currentIndex = index;
    notifyListeners();
  }
}
