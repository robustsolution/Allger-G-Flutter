import 'dart:convert';

import 'package:allger/Helpers/constant.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LanguagePage/languageItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:within/Models/index.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppProvider>(context, listen: listen);

  //  Language
  List<LangItem> _selectLangList = [];
  List<LangItem> get selectLangList => _selectLangList;
  void setSelectLangList(List<LangItem> selectLangList,
      {bool isNotifiable = true}) async {
    _selectLangList = selectLangList;
    if (isNotifiable) notifyListeners();
  }

  LangItem _currentLang = Constant.langList[0];
  LangItem get currentLang => _currentLang;
  void setCurrentLang(LangItem lang) {
    _currentLang = lang;
    notifyListeners();
  }

  // // ------ CURRENT DATE ------
  // DateTime _currentDate = DateTime.now();
  // DateTime get getCurrentDate => _currentDate;
  // void setCurrentDate(DateTime date) {
  //   _currentDate = date;
  // }

  // // ------ Food List -------
  // List<String> _foodList = [];

  // List<String> get foodList => _foodList;
  // Future<void> setfoodList(List<String> foodList,
  //     {bool isNotifiable = true}) async {
  //   _foodList = foodList;
  //   if (isNotifiable) notifyListeners();
  // }

  // // Map<String, String> _foodMapList;
  // Map<String, String> get foodMapList => _foodMapList;

  // Future<void> setfoodMapList(Map<String, String> foodMapList,
  //     {bool isNotifiable = true}) async {
  //   _foodMapList = foodMapList;
  //   if (isNotifiable) notifyListeners();
  // }

  // // ------ Dream List -------
  // List<String> _dreamList = [];
  // List<String> get dreamList => _dreamList;
  // Future<void> setdreamList(List<String> dreamList,
  //     {bool isNotifiable = true}) async {
  //   _dreamList = dreamList;
  //   if (isNotifiable) notifyListeners();
  // }

  // // ------ Medicine List -------
  // List<String> _medicineList = [];
  // List<String> get medicineList => _medicineList;
  // Future<void> setmedicineList(List<String> medicineList,
  //     {bool isNotifiable = true}) async {
  //   _medicineList = medicineList;
  //   if (isNotifiable) notifyListeners();
  // }
}
