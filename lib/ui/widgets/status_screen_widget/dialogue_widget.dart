import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/status_provider.dart';

class DialogueWidget extends StatelessWidget {
  const DialogueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(builder: (context, value, widget) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: value.isDownLoading
                  ? SizedBox(
                     height: MediaQuery.of(context).size.height/7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('DOWNLOADING...',style: TextStyle(fontWeight: FontWeight.bold,fontSize:18),),
                          ),
                          Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Please wait for a while',),
                        ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(),
                          )
                        ],
                      ),
                  )
                  : SizedBox(
                    height: MediaQuery.of(context).size.height/7,
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('DOWNLOAD SUCCESS !!',style: TextStyle(fontWeight: FontWeight.bold,fontSize:18),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Your Image is saved to ',),
                        ),
                        Text('Gallery -> WA Saver ',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
              actions:value.isDownLoading?null: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          });
  }
}