import 'dart:math' as math;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Controller/sharepreference.dart';

class DetailScreen extends StatefulWidget {
  final dynamic value;
  final name;

  const DetailScreen({super.key, this.value, this.name});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

List<String> planetName = [];

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    valueFunction();
    super.initState();
  }

  List<String>? valuex;

  valueFunction() {
    SharedPref.getListString().then((value) {
      print(value);
      setState(() {
        valuex = value;
        print(valuex);
      });
    });
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                planetName.add(widget.value['name']);

                SharedPref.setListString(token: planetName);
                valueFunction();
              },
              child: Icon(
                Icons.favorite,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Hero(
                  tag: widget.value['hero'],
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(widget.value["image"]))),
                  ),
                ),
              ),
            ),
          )),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  automaticallyImplyLeading: false,
                  pinned: true,
                  titleSpacing: -0.1,
                  title: Text(
                    "${widget.value['name']}",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: Text(
                      "${widget.value['distance']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: Text(
                      "${widget.value['description']}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
