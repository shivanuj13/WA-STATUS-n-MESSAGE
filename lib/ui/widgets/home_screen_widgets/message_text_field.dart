import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
   const MessageTextField({Key? key, required this.message}) : super(key: key);
 final TextEditingController message;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  ]
                 ),
                  child: TextField(
                    maxLines: 3,
                    controller: message,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      hintText: "Enter Your Message (Optional)",
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
                              borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                );
  }
}