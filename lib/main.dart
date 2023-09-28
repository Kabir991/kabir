import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled8/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ListViewBuilder());
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ListView.builder")),
      body: FutureBuilder(
          future: service.apifatch(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData){

              Map map = jsonDecode(snapshot.data);

              List mydata = map['tv_shows'];

              return ListView.builder(
                  itemCount: mydata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text('${mydata[index]['name']}'));
                  });
            } if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Container();
          }),
    );
  }
}
