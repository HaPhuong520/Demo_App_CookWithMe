// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    Food({
        required this.foodName,
        required this.img,
        required this.material,
        required this.recipes,
        required this.nutrition,
    });

    String foodName;
    String img;
    String material;
    String recipes;
    String nutrition;

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodName: json["foodName"],
        img: json["img"],
        material: json["material"],
        recipes: json["recipes"],
        nutrition: json["nutrition"],
    );

    Map<String, dynamic> toJson() => {
        "foodName": foodName,
        "img": img,
        "material": material,
        "recipes": recipes,
        "nutrition": nutrition,
    };
}
