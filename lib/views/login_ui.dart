import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/img_icon.dart';
import 'home_page.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final formLoginKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String inputUsername = '';
  String inputPassword = '';
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.white,
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "Cook with me",
                    style: GoogleFonts.fredokaOne(
                        textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontStyle: FontStyle.italic)),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                                child: ClipOval(
                              child: Image.asset(
                                ImageData.imgLogo,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Form(
                                key: formLoginKey, // globalkey để tìm kiếm form
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: usernameController,
                                      onChanged: (value) {
                                        setState(() {
                                          inputUsername = value.toString();
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email không được để trống';
                                        }
                                        if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value)) {
                                          return 'Định dạng email không đúng';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: inputUsername.isEmpty
                                              ? Container(
                                                  width: 0,
                                                )
                                              : IconButton(
                                                  color: const Color.fromARGB(
                                                      255, 81, 48, 67),
                                                  icon: const Icon(Icons.close),
                                                  onPressed: () => setState(() {
                                                        inputUsername = '';
                                                        usernameController
                                                            .clear();
                                                      })),
                                          prefixIcon: const Icon(
                                            Icons.people,
                                            color:
                                                Color.fromARGB(255, 81, 48, 67),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 238, 190, 206),
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 238, 190, 206),
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: Color.fromARGB(255, 84, 76, 79), width: 1),
                                              borderRadius: BorderRadius.all(Radius.circular(30))),
                                          hintText: 'cookwithme@gmail.com',
                                          labelText: 'Enter your email',
                                          labelStyle: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: TextFormField(
                                        controller: passwordController,
                                        onChanged: (value) {
                                          setState(() {
                                            inputPassword = value.toString();
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password không được để trống';
                                          }
                                          if (value.length < 8) {
                                            return 'Password phải từ 8 kí tự trở lên';
                                          }
                                          if (!RegExp(
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                              .hasMatch(value)) {
                                            return 'Password phải bao gồm: chữ hoa, thường, số và ký tự dặc biệt';
                                          }
                                          return null;
                                        },
                                        obscureText: isPasswordVisible,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                icon: isPasswordVisible
                                                    ? const Icon(
                                                        Icons.visibility_off)
                                                    : const Icon(
                                                        Icons.visibility),
                                                onPressed: () => setState(() {
                                                      isPasswordVisible =
                                                          !isPasswordVisible;
                                                    })),
                                            prefixIcon: const Icon(
                                              Icons.key,
                                              color: Color.fromARGB(
                                                  255, 81, 48, 67),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 238, 190, 206),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 238, 190, 206),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            enabledBorder: const OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: Color.fromARGB(255, 84, 76, 79), width: 1),
                                                borderRadius: BorderRadius.all(Radius.circular(30))),
                                            labelText: 'Enter your password',
                                            errorMaxLines: 2,
                                            hintText: 'Abc1234567!',
                                            labelStyle: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 40),
                                      child: RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          fillColor: const Color.fromARGB(
                                              255, 215, 123, 154),
                                          child: Container(
                                            width: double.infinity,
                                            height: 45,
                                            padding: const EdgeInsets.all(10),
                                            child: const Center(
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (formLoginKey.currentState!
                                                .validate()) {
                                              // validate input
                                              User? user =
                                                  await loginUsingEmailandPassword(
                                                      email: usernameController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim());
                                              if (user != null) {
                                                if (!mounted) return;
                                                const snackBar = SnackBar(
                                                // show snackbar
                                                content:
                                                    Text('Login successful'),
                                                duration: Duration(seconds: 2),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              formLoginKey.currentState!
                                                  .save(); //save data
                                              Navigator.push(
                                                  //go to HomePage app
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePage()));
                                              }else{
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(content: Text('Email hoặc password không đúng')));
                                              }
                                            }
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox())
            ],
          ),
        ));
  }

  // check login
  static Future<User?> loginUsingEmailandPassword(
      {required String email, required String password}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        print('Not found user');
      }
    }
    return user;
  }
}
