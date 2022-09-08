import 'package:cook_with_me/controller/rest_api.dart';
import 'package:cook_with_me/views/add_food_page.dart';
import 'package:cook_with_me/views/food_details_page.dart';
import 'package:flutter/material.dart';

import '../models/food.dart';

class HomePageFood extends StatefulWidget {
  const HomePageFood({Key? key}) : super(key: key);

  @override
  State<HomePageFood> createState() => _HomePageFoodState();
}

class _HomePageFoodState extends State<HomePageFood> {
  final TextEditingController nameFoodController = TextEditingController();
  String inputFoodName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: const Text("List Food"),
        title: TextField(
          controller: nameFoodController,
          onChanged: (value) {
            setState(() {
              inputFoodName = value.toString();
            });
          },
          cursorColor: Colors.pink,
          decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.all(15),
              hintText: 'Search',
              suffixIcon: inputFoodName == ''
                  ? Container(
                      width: 0,
                    )
                  : IconButton(
                      color: const Color.fromARGB(255, 81, 48, 67),
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          inputFoodName = '';
                          nameFoodController.clear();
                        });
                      },
                    )),
        ),
        backgroundColor: const Color.fromARGB(255, 231, 131, 164),
      ),
      body: SafeArea(child: _buildBody(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFoodPage()));
        },
        backgroundColor: Colors.pink,
        tooltip: 'Add a new food',
        child: const Icon(Icons.add),
      ),
    );
  }

// build list view
  FutureBuilder<List<Food>> _buildBody(BuildContext context) {
    final RestAPI httpService = RestAPI();
    return FutureBuilder<List<Food>>(
        future: inputFoodName.isEmpty
            ? httpService.getAllFood()
            : httpService.searchFood(inputFoodName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Food>? foods = snapshot.data;
            // if (foods == null) {
            //   print('khsdv');
            //   return const Center(
            //     child: Text(
            //       'Oops, món này chưa tồn tại',
            //       style: TextStyle(fontSize: 50),
            //     ),
            //   );
            // }
            return _buildFoods(context, foods!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  // build list food (img and food name)

  ListView _buildFoods(BuildContext context, List<Food> foods) {
    return ListView.builder(
      itemCount: foods.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          color: (index % 2 == 0) ? Colors.white : Colors.grey[200],
          // : const Color.fromARGB(255, 229, 223, 224),
          elevation: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FoodDetailsPage(food: foods[index])));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      foods[index].img,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        foods[index].foodName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    // books[index].tittle,
                    // style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
