import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  int currentIndex = 0;
  String ans = '', res = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 131, 164),
        title: const Text("BMI - Body Mass Index"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    customButton("Woman", Colors.pink, 0),
                    customButton("Man", Colors.blue, 1),
                  ],
                ), const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Nhập chiều cao (cm): ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "180",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Nhập cân nặng (kg): ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "60",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                  child: RawMaterialButton(
                    onPressed: () {
                      if (heightController.value.text.isEmpty ||
                          weightController.value.text.isEmpty) {
                        setState(() {
                          res = 'Bạn cần phải nhập đủ thông tin';
                        });
                      } else {
                        double h = double.parse(heightController.value.text);
                        double w = double.parse(weightController.value.text);
                        calculateBMI(h, w);
                        double bmi = double.parse(ans);
                        res = message(bmi);
                      }
                    },
                    fillColor: const Color.fromARGB(255, 215, 123, 154),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          'Kiểm tra',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: (ans.isEmpty)
                                    ? ''
                                    : 'Chỉ số BMI của bạn là: ',
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                    color: Colors.grey)),
                            TextSpan(
                                text: ans,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.pink))
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(children: [
                            Flexible(
                              child: Text(
                                res,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ]),
                        )
                      ]),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: double.infinity,
                    height: 30,
                    child: Link(
                        uri: Uri.parse('https://radiosuckhoe.com/bmi/'),
                        builder: (context, followLink) => GestureDetector(
                              onTap: followLink,
                              // ignore: prefer_const_constructors
                              child: Text(
                                '(*): Tham khảo tại đây',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  calculateBMI(double h, double w) {
    h /= 100;
    setState(() {
      ans = (w / (h * h)).toStringAsFixed(2);
    });
  }

  String message(double bmi) {
    if (bmi < 15) {
      return 'Bạn đang trong tình trạng Thiếu cân rất nặng*';
    }
    if (bmi <= 15.9) {
      return 'Bạn đang trong tình trạng Thiếu cân nặng*';
    }
    if (bmi <= 18.4) {
      return 'Bạn đang trong tình trạng Thiếu cân*';
    }
    if (bmi <= 22.9) {
      return 'Bạn đang ở mức lý tưởng rồi đấy <3*';
    }
    if (bmi == 23) {
      return 'Oops, bạn bị thừa cần mất rồi*';
    }
    if (bmi <= 24.9) {
      return 'Bạn đang trong tình trạng Tiền béo phì*';
    }
    if (bmi <= 29.9) {
      return 'Bạn đang trong tình trạng Béo phì độ I*';
    }
    if (bmi == 30) {
      return 'Bạn đang trong tình trạng Béo phì độ II*';
    }
    return 'Bạn đang trong tình trạng Béo phì độ III*';
  }

  changeIndex(int id) {
    setState(() {
      currentIndex = id;
    });
  }

  Widget customButton(String str, Color color, int id) {
    return Expanded(
        child: Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        color: currentIndex == id ? color : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          changeIndex(id);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(id == 0 ? Icons.female : Icons.male),
            Text(str,
                style: TextStyle(
                    color: currentIndex == id ? Colors.white : color,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))
          ],
        ),
        // child: Text(
        //   str,
        //   style: TextStyle(
        //     color: currentIndex == id ? Colors.white : color,
        //   ),
        // ),
      ),
    ));
  }
}
