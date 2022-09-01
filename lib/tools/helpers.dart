import 'dart:convert';

import 'package:get/get.dart';
import 'package:hadafo/controller/utils.controller.dart';


final utCtrl = Get.find<UtilsController>();
class Helpers {



  static isJsonParsable (string) {
    try {
        jsonDecode(string);
    } catch (e) {
        return false;
    }
    return true;
  }


  static List<dynamic> response(data, int status){
    if(isJsonParsable(data)){
      if(status == 200 && (jsonDecode(data) != null || jsonDecode(data) != false)){
        return [jsonDecode(data), "" , 200];
      }else {
        if(status == 409){
          return ["", "Une erreur de connexion s'est produite", 409];
        }
        if(jsonDecode(data) != null && jsonDecode(data)['error'] != null) {
          return ["", jsonDecode(data)['error'], status];
        }
        return  ['', 'une erreur inconnue s\'est produite', status];
      }
    }
    else if(status == 409) {
      return ["", "Une erreur de connexion s'est produite", 409];
    } else {
      return ['', 'Une erreur du serveur s\'est produite', 404];
    }
  }


  static dateFormat(month) {
    switch (month) {
      case '01':
        return 'janvier';
      case '02':
        return 'février';
      case '03':
        return 'mars';
      case '04':
        return 'avril';
      case '05':
        return 'mai';
      case '06':
        return 'juin';
      case '07':
        return 'juillet';
      case '08':
        return 'août';
      case '09':
        return 'septembre';
      case '10':
        return 'octobre';
      case '11':
        return 'novembre';
      case '12':
        return 'décembre';
      default:
        return '';
    }
  }

  static String date(getDate, {le ='le '}) {
    var date = getDate.substring(0,10);
    var month = date.substring(5, 7);
    var day = date.substring(8, 10);
    return "$day ${Helpers.dateFormat(month)}, ${date.substring(0, 4)}";
  }


  static bool theme(){
    if(utCtrl.isDarkMode.value) {
      return true;
    } else {
      return false;
    }
  }
}
