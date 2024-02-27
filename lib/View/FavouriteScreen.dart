import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Controller/sharepreference.dart';
import 'DetailScreen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    readJson();
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

  List _items = [];
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/images/planets.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  searchText(txtvalue) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i]['name'] == txtvalue) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(value: _items[i]),
            ));
      } else {
        print("not found");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Planets"),
        centerTitle: true,
      ),
      body: valuex == null
          ? Center(child: Text("No Favourite is Added"))
          : ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    searchText(valuex![index]);
                  },
                  child: ListTile(
                    trailing: Icon(Icons.favorite),
                    title: Text(valuex!.toSet().toList()[index]),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: valuex!.toSet().toList().length),
    );
  }
}
