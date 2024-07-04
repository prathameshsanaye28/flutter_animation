import 'package:crtd/colors.dart';
import 'package:crtd/reusable_widget.dart';
import 'package:crtd/screens/expandable_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  late PageController pageController;


  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                width: 100,
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: _page == 0 ? secondaryColor : Colors.grey,                
                    ),
                    SizedBox(width: 10,),
                    Text("Home", style: TextStyle(color: secondaryColor),),
                  ],
                ),
              ),
              //label: "Home",
              backgroundColor: secondaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: _page == 1 ? secondaryColor : primaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mail,
                color: _page == 2 ? secondaryColor : primaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: _page == 3 ? secondaryColor : primaryColor,
              ),
              label: "",
              backgroundColor: primaryColor),
          
        ],
        onTap: navigationTapped,
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: primaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hey James,",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: secondaryColor),
                        ),
                        CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      ],
                    ),
                    Text(
                      "What would you like to do today?",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: secondaryColor),
                    )
                  ],
                ),
              ),
              ExpandableSection(onExpansionChanged: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }),
              Container(
                color: secondaryColor,
                child: Column(
                  children: [
                    peopleInfo("Alexander Young", "Groceries-19 Feb 19",
                        Colors.blue, true, "\$500.00", "Sent"),
                    peopleInfo("Lisa Monroe", "School Fee-20 Feb 19",
                        Colors.green, false, "\$1500.00", "Received"),
                    peopleInfo("Bryan Valdez", "Hospital-15 Feb 19",
                        Colors.amber, true, "\$700.00", "Pending"),
                    peopleInfo("Alex Grover", "Stationery-17 Feb 19",
                        Colors.blue, false, "\$100.00", "Sent"),
                    peopleInfo("Sia Shah", "Food-09 Feb 19", Colors.green,
                        false, "\$800.00", "Received"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
