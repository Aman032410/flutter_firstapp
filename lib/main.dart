
import 'package:flutter/material.dart';
import 'dart:async' ;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {


    var data = await http.get("https://jsonplaceholder.typicode.com/todos");

    var jsonData = json.decode(data.body);

    List<User> users= [];
    for(var u in jsonData){
      User user = User(u["userId"], u["Id"], u["title"], u["complete"]);
      users.add(user);
    }
    print(users.length);

    return users;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('flutter listview in json'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if(snapshot.data== Null){
              return Container(
                child: Center(
                  child: Text("Loading...."),
                )
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int userId) {



                  return ListTile(
                    title: Text(snapshot.data[userId].title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
    ),

    );
  }
}
class User {
  final int userId;
  final int id;
  final String title;
  final String complete;

  User(this.userId, this.id, this.title, this.complete);
}
