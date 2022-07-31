import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
   const PhoneTextField({Key? key, required this.phone}) : super(key: key);
  final TextEditingController phone;

  @override
  Widget build(BuildContext context) {
    return   Container(
                   decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    const BoxShadow(
                      color:Color.fromARGB(255, 31, 31, 31),
                    ),
                    BoxShadow(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      spreadRadius: -2,
                      blurRadius: 6,
                       blurStyle: BlurStyle.inner
                    )
                  ]),
                  child: TextField(
                    maxLength: 10,
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 20, letterSpacing: 3),
                    decoration: InputDecoration(
                        counterText: '',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.phone),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        hintText: "Enter Mobile No",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                );
  }
}