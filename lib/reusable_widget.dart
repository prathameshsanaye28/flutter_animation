import 'package:crtd/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildFeature(IconData iconData, String text, bool isExpanded) {
  return Column(
    children: [
      Container(
        height: isExpanded?70:55,
        width: 50,
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(7.5))),
        child: Icon(
          iconData,
          color: Colors.blue,
          size: 40,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        text,
        style:  TextStyle(
            color: isExpanded?Colors.black54:secondaryColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget peopleInfo(String name, String subtitle, Color avatarColor, bool isUp,
    String amount, String status) {
  return Container(
    color: Colors.grey[350],
    child: Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Stack(
                //alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 30,
                    //backgroundImage: NetworkImage(avatarUrl),
                    child: Icon(Icons.people),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: avatarColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isUp ? Icons.arrow_upward : Icons.arrow_downward,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.5),
                      ),
                      Text(
                        status,
                        style: TextStyle(color: avatarColor),
                      ),
                    ],
                  ),
                ),
              ),
              //Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
        //SizedBox(height: 10,)
      ],
    ),
  );
}

const homeScreenItems = [
  Text('search'),
  Text('search'),
  Text('search'),
  Text('favorite'),
  Text('profile'),
];

Widget sendMoney(String name, String subtitle) {
  return Container(
    //color: Colors.grey[350],
    child: Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                //backgroundImage: NetworkImage(avatarUrl),
                child: Icon(
                  Icons.people,
                  size: 45,
                ),
              ),

              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              //Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
        //SizedBox(height: 10,)
      ],
    ),
  );
}
