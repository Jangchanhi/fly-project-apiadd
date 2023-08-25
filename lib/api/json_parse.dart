import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:tmap_raster_flutter_sample/api/service.dart';
import 'package:tmap_raster_flutter_sample/api/user.dart';
import 'user.dart';

class JsonParse extends StatefulWidget {
  const JsonParse({super.key});

  @override
  State<JsonParse> createState() => _JsonParseState();
}

//
class _JsonParseState extends State<JsonParse> {

  List<User> _user = <User>[];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Services.getInfo().then((value){
      setState(() {
        _user = value as List<User>;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'User' : 'Loading...'),
      ),
      body: ListView.builder(
        itemCount : _user.length,
        itemBuilder : (context, index){
          User user = _user[index];
          return ListTile(
            leading: const Icon(
              Icons.account_circle_rounded,
              color: Colors.blue
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.phone_android_outlined,
                color: Colors.red,
              ),
             onPressed: () {
               showDialog(
                   context: context,
                   builder: (context){
                     return AlertDialog(
                       title: Text(user.name),
                       content: Colum(
                         children: [
                           Text(user.phone),
                         ],
                       ),
                     );
                   },
                );
            },
          ),
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}
