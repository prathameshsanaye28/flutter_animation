import 'package:crtd/colors.dart';
import 'package:crtd/reusable_widget.dart';
import 'package:crtd/screens/send_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ExpandableSection extends StatefulWidget {
  final VoidCallback onExpansionChanged;

  const ExpandableSection({Key? key, required this.onExpansionChanged})
      : super(key: key);

  @override
  _ExpandableSectionState createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 0 && !_isExpanded) {
          _toggleExpand();
        } else if (details.primaryDelta! < 0 && _isExpanded) {
          _toggleExpand();
        }
      },
      child: AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
  return Container(
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    child: Column(
      children: <Widget>[
        _buildHeader(),
        ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: _buildExpandedContent(),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildHeader() {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 300),
      crossFadeState:
          _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: _buildHorizontalLayout(),
      secondChild: SizedBox(height: 20),
    );
  }

  double _dragPosition = 0;

  Widget _buildHorizontalLayout() {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 119, 110, 253),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_left,
                              color: secondaryColor,
                              size: 35,
                            ),
                            Text('Receive',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.5)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Send',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.5)),
                            Icon(
                              Icons.arrow_right,
                              color: secondaryColor,
                              size: 35,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragPosition += details.delta.dx;
                      _dragPosition = _dragPosition.clamp(-80.0, 80.0);
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_dragPosition < -25) {
                      //_onReceiveSelected();
                    } else if (_dragPosition > 25) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendScreen()));
                    }
                    setState(() {
                      _dragPosition = 0;
                    });
                  },
                  child: Transform.translate(
                    offset: Offset(_dragPosition, 0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.music_note, color: Color(0xFF4A5FC1)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 231, 231),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildFeature(Icons.receipt, "Pay Bills",true),
                      buildFeature(Icons.health_and_safety, "Donate",true),
                      buildFeature(Icons.people, "Recipeints",true),
                      buildFeature(Icons.percent, "Offers",true)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


Widget _buildExpandedContent() {
  return Container(
    color: primaryColor,
    height: 500, // Set a fixed height for debugging
    child: Row(
      children: [
        // Vertical slider
        Expanded(
          flex: 1,
          child: _buildVerticalSlider(),
        ),
        // Circular tasks
        Expanded(
          flex: 2,
          child: _buildSemiCircularTasks(),
        ),
      ],
    ),
  );
}

Widget _buildVerticalSlider() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 80,
        height: 400,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 119, 110, 253),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Icons.arrow_upward, color: secondaryColor, size: 35),
                  Text('Send', style: TextStyle(color: Colors.white, fontSize: 17.5)),
                ],
              ),
              Column(
                children: [
                  Text('Receive', style: TextStyle(color: Colors.white, fontSize: 17.5)),
                  Icon(Icons.arrow_downward, color: secondaryColor, size: 35),
                ],
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _dragPosition += details.delta.dy;
            _dragPosition = _dragPosition.clamp(-160.0, 160.0);
          });
        },
        onVerticalDragEnd: (details) {
          if (_dragPosition < -25) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendScreen()));
          } else if (_dragPosition > 25) {
            // Handle receive action
          }
          setState(() {
            _dragPosition = 0;
          });
        },
        child: Transform.translate(
          offset: Offset(0, _dragPosition),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.music_note, color: Color(0xFF4A5FC1)),
          ),
        ),
      ),
    ],
  );
}


/*Widget _buildSemiCircularTasks() {
  final double radius = 150;
  final List<Map<String, dynamic>> tasks = [
    {'icon': Icons.receipt, 'label': 'Pay Bills'},
    {'icon': Icons.favorite, 'label': 'Donate'},
    {'icon': Icons.people, 'label': 'Recipients'},
    {'icon': Icons.percent, 'label': 'Offers'},
  ];

  return Container(
    alignment: Alignment.centerRight,
    width: radius,
    height: radius*2,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Semi-circle shape
        Container(
          width: radius,
          
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 54, 9, 233),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              //topRight: Radius.circular(radius),
              //bottomRight: Radius.circular(radius*2),
            ),
          ),
        ),
        // Tasks along the semi-circle border
        ...List.generate(tasks.length, (index) {
          final double angle = math.pi * ((index+1) / (tasks.length));
          return Positioned(
            left: radius + radius * math.cos(angle),
            top: radius - radius * math.sin(angle) - 30, // Adjust this value to move icons up or down
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(tasks[index]['icon'], color: secondaryColor, size: 24),
                SizedBox(height: 4),
                Text(
                  tasks[index]['label'],
                  style: TextStyle(color: secondaryColor, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}*/


 Widget _buildSemiCircularTasks() {
    final double radius = 200;
    final List<Map<String, dynamic>> tasks = [
      {'icon': Icons.receipt, 'label': 'Pay Bills'},
      {'icon': Icons.favorite, 'label': 'Donate'},
      {'icon': Icons.people, 'label': 'Recipients'},
      {'icon': Icons.percent, 'label': 'Offers'},
    ];

    return Container(
      alignment: Alignment.centerRight,
      width: radius*2,
      height: radius * 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Semi-circle shape
          Container(
            width: radius,
            height: radius * 2,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 54, 9, 233),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
            ),
          ),
          // Tasks along the semi-circle border
           ...List.generate(tasks.length, (index) {
          final double angle = (index + 1) * (math.pi / (tasks.length + 1));
          final double x = radius - radius * math.cos(angle) - 20;
          final double y = radius - radius * math.sin(angle) - 10;
          return Positioned(
            left: y,
            bottom: x-20,
            child: buildFeature(tasks[index]['icon'], tasks[index]['label'], false),
          );
        }),
      ],
    ),
  );
}

  

  Widget _buildActionButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF4A5FC1),
        backgroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}

_onSendSelected(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SendScreen()));
}