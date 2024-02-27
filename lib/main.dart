import 'dart:convert';
import 'dart:math' as math;
import 'package:curved_carousel/curved_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Controller/themeprovider.dart';
import 'Controller/valuechecker.dart';
import 'View/DetailScreen.dart';
import 'View/FavouriteScreen.dart';
import 'View/SplashScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<valueUpdater>(
          create: (_) => valueUpdater(),
        ),
        ChangeNotifierProvider<ModelTheme>(
          create: (_) => ModelTheme(),
        )
      ],
      child: Consumer<ModelTheme>(
        builder: (context, themes, child) {
          return MaterialApp(
            theme: themes.isDark
                ? ThemeData.dark(useMaterial3: true)
                : ThemeData.light(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: SlideTransitionWidget(),
          );
        },
      ),
    ),
  );
}

List _items = [];

_buildname(valueText) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      width: width / 2,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: _items[valueText]["name"],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "\nLeanthOfYear:",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: _items[valueText]["leanthOfYear"],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )
          ])),
    ),
  );
}

var width;

class WheelExample extends StatefulWidget {
  WheelExample({super.key});

  @override
  State<WheelExample> createState() => _WheelExampleState();
}

class _WheelExampleState extends State<WheelExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 15))
        ..repeat();

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/images/planets.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  @override
  void initState() {
    readJson();
    print(_items);
    // TODO: implement initState
    super.initState();
  }

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final themedata = Provider.of<ModelTheme>(context);
    width = MediaQuery.of(context).size.width;
    return _items.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.9,
                    filterQuality: FilterQuality.high,
                    image: NetworkImage(
                        'https://static.wixstatic.com/media/0d39e6_e6af45aaa0264817a862ef2b5470cbd7~mv2.gif'),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,

              appBar: PreferredSize(
                preferredSize: Size(width / 2, 50),
                child: AppBar(
                  title: Text("Galaxy Planets"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavouriteScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Switch(
                        value: themedata.isDark,
                        onChanged: (value) {
                          themedata.isDark = !themedata.isDark;
                        },
                      ),
                    )
                  ],
                ),
              ),
              // drawer: Drawer(
              //   width: width / 1.3,
              //   child: ListView(
              //     padding: const EdgeInsets.all(0),
              //     children: [
              //       SizedBox(
              //         height: 50,
              //       ),
              //       ListTile(
              //         trailing: Icon(Icons.edit),
              //         title: Text("Ronak Pithava"),
              //         subtitle: Text("ronakpithava0341@gmail.com"),
              //         leading: Icon(
              //           Icons.person,
              //           size: 40,
              //         ),
              //       ),
              //       ListTile(
              //         leading: !themedata.isDark
              //             ? Icon(Icons.light_mode)
              //             : Icon(Icons.shield_moon),
              //         title: const Text('Theme'),
              //         trailing: Switch(
              //           value: themedata.isDark,
              //           onChanged: (value) {
              //             themedata.isDark = !themedata.isDark;
              //           },
              //         ),
              //       ),
              //       ListTile(
              //         leading: const Icon(Icons.favorite),
              //         title: const Text(' Favourite '),
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => FavouriteScreen(),
              //               ));
              //         },
              //       ),
              //     ],
              //   ),
              // ), //
              body: Stack(
                children: [
                  Consumer<valueUpdater>(
                    builder: (context, vax, child) {
                      return Transform.rotate(
                        angle: 1.5,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          // color: Colors.amber,
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: CurvedCarousel(
                              onChangeStart: (index, automatic) =>
                                  vax.valueSet = index,
                              middleItemScaleRatio: 3,
                              curveScale: 150,
                              horizontalPadding: 10,
                              tiltItemWithcurve: true,
                              itemBuilder: (p0, p1) {
                                return AnimatedBuilder(
                                  animation: _controller,
                                  builder: (_, child) {
                                    return Transform.rotate(
                                      angle: _controller.value * 2 * math.pi,
                                      child: child,
                                    );
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(value: _items[p1]),
                                          ));
                                    },
                                    child: Hero(
                                      tag: _items[p1]['hero'],
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 100,
                                                  spreadRadius: 2,
                                                  color: Colors.blueAccent
                                                      .withOpacity(0.9))
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    _items[p1]["image"]),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _items.length,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Consumer<valueUpdater>(
                    builder: (context, value, child) {
                      return Align(
                          alignment: Alignment(-0.9, 0.5),
                          child: _buildname(value.getValue));
                    },
                  )
                ],
              ),
            ),
          );
  }
}
