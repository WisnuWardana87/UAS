import 'package:projek_uas/ui/berandaadmin.dart';
import 'package:projek_uas/ui/inputpenjualan.dart';
import 'package:projek_uas/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projek_uas/ui/home.dart';

class Berandauser extends StatefulWidget{
  @override
  _BerandauserState createState() => _BerandauserState();
}

class _BerandauserState extends State<Berandauser> {
  String id, nama, email, photo;
  int level=0;
  getPref()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      level=preferences.getInt("level");
      id=preferences.getString("id");
      nama=preferences.getString("nama");
      email=preferences.getString("email");
      photo=preferences.getString("photo");
    });
  }
  signOut() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("level",0);
    });
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context)=>Login()
      ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context){
    switch (level) {
      case 1:
        return Berandaadmin();
        break;
      case 2:
        return Scaffold(
          appBar: AppBar(
            title: Text("Beranda User"),
          ),
          body: Center(
            child: Text("Ini Beranda User"),
            ),
          );
      break;
    default:    
      return Login();
    }
  }
}