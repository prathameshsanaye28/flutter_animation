import 'package:crtd/colors.dart';
import 'package:crtd/reusable_widget.dart';
import 'package:flutter/material.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              color: secondaryColor,
            )),
        title: Text(
          "Send Money",
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(color: secondaryColor)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Payee",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Icon(
                          Icons.search,
                          color: primaryColor,
                        )
                      ],
                    ),
                  )),
                sendMoney("Eric Peterson", "9999888853"),
                sendMoney("Alex Grover", "9999888853"),
                sendMoney("Bryan Valdez", "9999888853"),
                sendMoney("Lisa Monroe", "9999888853"),
                sendMoney("Alexander Young", "9999888853"),
                sendMoney("Douglas Adams", "9999888853"),
            ],
          ),
        ),
      ),
    );
  }
}
