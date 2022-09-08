import 'dart:io';
import 'package:cook_with_me/controller/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../data/img_icon.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  File? image;
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodMaterialController = TextEditingController();
  TextEditingController foodRecipesController = TextEditingController();
  TextEditingController foodNutritionController = TextEditingController();
  late String foodImg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 231, 131, 164),
          title: const Text('Thêm món')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Bạn đã lên sóng món này ở đâu chưa?',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextField(
                  controller: foodNameController,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Tên món: Bánh bột mì",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Text(
                  'Nguyên liệu: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextField(
                  controller: foodMaterialController,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Bột mì, trứng gà,....",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Text(
                  'Chất dinh dưỡng: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextField(
                  controller: foodNutritionController,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Chất béo/ Chất bột đường,...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Text(
                  'Cách làm: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextField(
                  controller: foodRecipesController,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Trộn đều bột mì và trứng,...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Text(
                  'Thêm ảnh',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: RawMaterialButton(
                    onPressed: () async {
                      pickImage();
                      // RestAPI httpServices = RestAPI();
                      // bool x = await httpServices.uploadNewFood(foodNameController.text, foodMaterialController.text, foodRecipesController.text, foodNutritionController.text, image);
                      // if(x){
                      //   // ignore: use_build_context_synchronously
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //     content: Text("Upload thành công"),
                      //     duration: Duration(seconds: 2),
                      //     ));

                      // }
                    },
                    fillColor: const Color.fromARGB(255, 215, 123, 154),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      width: 150,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          'Chọn ảnh',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  // ignore: unnecessary_null_comparison
                  child: image != null
                      ? Image.file(
                          image!,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          ImageData.imgCamera,
                          height: 80,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                    child: RawMaterialButton(
                  onPressed: () async {
                    RestAPI httpServices = RestAPI();
                    bool x = await httpServices.uploadNewFood(
                        foodNameController.text,
                        foodMaterialController.text,
                        foodRecipesController.text,
                        foodNutritionController.text,
                        image);
                    if (x) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Upload thành công"),
                        duration: Duration(seconds: 2),
                      ));
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Lỗi khi upload"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  fillColor: const Color.fromARGB(255, 215, 123, 154),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                     width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                    child: const Text(
                      'Lên sóng',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              )
            ],
          ),
        ),
      )),
    );
  }

  // get imgae from gallery
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      setState(() {
        this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Lỗi: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Lỗi rồi'),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
