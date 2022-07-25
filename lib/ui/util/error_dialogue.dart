
import 'package:flutter/material.dart';

AlertDialog errorDialogue(BuildContext context, Future <void> Function(BuildContext context) onPressed) {
  return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: const Text('Storage permission are required !!'),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(onPressed: ()async {
          Navigator.pop(context);
           await onPressed(context);
        }, child: const Text('Grant Permission'))
      ],
    );
}