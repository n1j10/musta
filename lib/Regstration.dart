import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'homeScreen.dart';

class RegiserScreen extends StatefulWidget {
  const RegiserScreen({super.key});

  @override
  State<RegiserScreen> createState() => _RegiserScreenState();
}

class _RegiserScreenState extends State<RegiserScreen> {
  bool startAnimation = false;
  AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.name,
              validator: (value) => value!.isEmpty ? 'Enter Your Name' : null,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.2),
                  hintText: 'Name',
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  )),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: controller.phone,
              validator: (value) =>
              value!.isEmpty ? 'Enter Your Phone number' : null,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.2),
                  hintText: 'Phone number',
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  )),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              obscureText: true,
              controller: controller.pass,
              validator: (value) =>
              value!.isEmpty ? 'Enter Your Password' : null,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.2),
                  hintText: 'Password',
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  )),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(
                  () => GestureDetector(
                onTap: () {
                  try {
                    if (controller.name.text.isNotEmpty &&
                        controller.phone.text.isNotEmpty &&
                        controller.pass.text.isNotEmpty) {
                      controller.isLoading.value = true;
                      controller.register().then((value) {
                        controller.isLoading.value = false;
                        if (value == "error to get result" || value == null) {
                          Fluttertoast.showToast(
                              msg: "Error to Register",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (value['status'] == 'failed') {
                          Fluttertoast.showToast(
                              msg: value['message'],
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          // sharedPreferences.setString(
                          //     "id", value['data']['User_id']);
                          // sharedPreferences.setString(
                          //     "name", value['data']['User_name']);
                          // sharedPreferences.setString(
                          //     "phone", value['data']['User_phone']);
                          Fluttertoast.showToast(
                              msg: 'Register Success',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          controller.clearTexts();
                          Get.off(() => const HomeScreen(),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 500));
                        }
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please Fill All Fields First to Register",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } catch (e) {
                    controller.isLoading.value = false;
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeInOut,
                  transform: Matrix4.translationValues(
                      0, startAnimation ? 0 : size.width, 0),
                  height: 49,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 3),
                            spreadRadius: 2,
                            blurRadius: 2)
                      ]),
                  child: Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.red)
                        : const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
