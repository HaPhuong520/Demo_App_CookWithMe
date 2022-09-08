import 'dart:convert';
import 'dart:io';

import 'package:cook_with_me/controller/food_services.dart';
import 'package:http/http.dart';
// ignore: library_prefixes
import 'package:dio/dio.dart' as Dio;

import '../models/food.dart';

class RestAPI {
  final String foodURL = 'https://haui-hit-food.herokuapp.com/api/food';
  // get all food
  Future<List<Food>> getAllFood() async {
    Response res = await get(Uri.parse(foodURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Food> foods = body
          .map(
            (dynamic item) => Food.fromJson(item),
          )
          .toList();

      return foods;
    } else {
      throw Exception("Unable to get foods.");
    }
  }

  // get food by name (search food)
  Future<List<Food>> searchFood(String nameFood) async {
    try {
      List<Food> foods = await RestAPI().getAllFood();
      return foods.where((f) {
        final nameFoodLower = f.foodName.toLowerCase();
        final searchLower = nameFood.toLowerCase();
        return nameFoodLower.contains(searchLower);
      }).toList();
    } catch (ex) {
      rethrow;
    }
  }

  // post a new food
  Future<bool> uploadNewFood(String foodName, String foodMaterial,
      String foodRecipes, String foodNutrition, File? fileImg) async {
    try {
      if (foodName.isEmpty ||
          foodMaterial.isEmpty ||
          foodNutrition.isEmpty ||
          foodRecipes.isEmpty) {
        return false;
      }
      Dio.FormData formData = Dio.FormData.fromMap({
        "foodName": foodName,
        "material": foodMaterial,
        "recipes": foodRecipes,
        "nutrition": foodNutrition,
        "img": await Dio.MultipartFile.fromFile(fileImg!.path,
            filename: fileImg.path.split('/').last)
      });
      bool result = await FoodServices.create(formData);
      return result;
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi khi thêm');
      return false;
    }
  }
}
