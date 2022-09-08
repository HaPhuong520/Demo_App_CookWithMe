import 'dart:async';

import 'package:dio/dio.dart';

class FoodServices{
static Future<bool> create(FormData data) async {
    try {
      Response response =
      await Dio().post(
          "https://haui-hit-food.herokuapp.com/api/food",
          data: data,
      );
      if(response.statusCode==201){
        return true;
      }
      return false;
    } catch(e){
      return false;
    }
  }
}