import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:projek_uas/ui/inputpenjualan.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _globalKey=new GlobalKey<ScaffoldState>();
  List penjualanList;
  int count = 0;

  Future<List> getData() async{
    final response=await http.get('http://192.168.43.190/flutter/Minuman/index');
    return json.decode(response.body);
  }
  @override
  void initState() {
    Future<List> penjualanListFuture=getData();
    penjualanListFuture.then((penjualanList){
      setState(() {
        this.penjualanList=penjualanList;
        this.count=penjualanList.length;
      });
    });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: new AppBar(
        title: Text("Penjualan Minuman"),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Input Penjualan',
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context)=> new InputPenjualan(list:null,index:null,)
          )
        )
      ),
    );
  }
  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(penjualanList[index]['nama'], style: textStyle,),
            subtitle: Row(
              children: <Widget>[
                Text(penjualanList[index]['tanggal'].toString()),
                Text(" | Rp. "+penjualanList[index]['harga'], style: TextStyle(fontWeight: FontWeight.bold),),
              ],
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: (){
                  confirm(penjualanList[index]['id'],penjualanList[index]['nama']);
                },
              ),
              onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                builder: (BuildContext context)=> new InputPenjualan(list:penjualanList[index],index:index,)
              )
            ),
          ),
        );
      },
    );
  }
  Future<http.Response> deletePenjualan(id) async{
    final http.Response response=await http.delete("http://192.168.43.190/flutter/Minuman/delete/$id");
    Future<List> penjualanListFuture=getData();
    penjualanListFuture.then((penjualanList){
      setState(() {
        this.penjualanList=penjualanList;
        this.count=penjualanList.length;
      });
    });
    return response;
  }
  void confirm(id,nama){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin Hapus '$nama'"),
      actions: <Widget>[
        new RaisedButton(
          child: Text("Ok Hapus"),
          color: Colors.red,
          onPressed: (){
            deletePenjualan(id);
            Navigator.of(context).pop();
            _globalKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Data '$nama' Berhasil Dihapus"),
                duration: Duration(seconds: 1),
                ),
            );
          },
        ),
        new RaisedButton(
          child: Text("Batal"),
          color: Colors.green,
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
    showDialog(context: context,child: alertDialog);
  }
}