import 'package:projek_uas/ui/berandaadmin.dart'; 
import 'package:projek_uas/ui/berandauser.dart'; 
import 'package:projek_uas/ui/home.dart'; 
import 'package:projek_uas/ui/login.dart'; 
import 'package:flutter/material.dart'; 
void main() => runApp(   
  new MaterialApp(     
    title: 'Penjualan Voucher',     
    home: Berandauser(),     
    routes: <String, WidgetBuilder>{         
      '/Berandauser': (BuildContext context) => new Berandauser(),         
      '/Berandaadmin': (BuildContext context) => new Berandaadmin(),         
      '/login':(BuildContext context)=>Login(),         
      '/Penjualan': (BuildContext context) => new Home(),       
      },   
    ) 
  ); 