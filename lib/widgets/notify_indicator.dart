import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/sign_up/presentation/bloc/signup_bloc.dart';

class Notify {
  static Future<void> success(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.green,
            alignment: Alignment.topRight,
            elevation: 0,
            content: Container(
              color: Colors.green,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
      },
    );
  }

  static Future<void> error(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.white10, // user must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: ()=>Navigator.pop(context),
          child: AlertDialog(
              backgroundColor: Colors.white10,
              alignment: Alignment.topRight,
              elevation: 0,
              content: Center(
                  child: Container(
                color: Colors.transparent,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 40,
                      color: Colors.red,
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ))),
        );
      },
    );
  }

   static Future<void> loading(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white10, // user must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          child: AlertDialog(
              backgroundColor: Colors.white10,
              alignment: Alignment.topRight,
              elevation: 0,
              content: Center(
                  child: Container(
                    color: Colors.transparent,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ))),
        );
      },
    );
  }


}
