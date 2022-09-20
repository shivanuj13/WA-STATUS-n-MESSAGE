import 'package:flutter/material.dart';

class PermissionDialogueWidget extends StatelessWidget {
   PermissionDialogueWidget({Key? key,required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
     return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: const Text("Since Android 11, you need to manually allow storage permission. Please click 'User this folder' and then allow."),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(onPressed: ()async {
          Navigator.pop(context);
          onTap();
        }, child: const Text('OK'))
      ],
    );
  }
}