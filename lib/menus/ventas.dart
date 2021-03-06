
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/componentes/constants.dart';
import 'package:flutter_application_1/controlador/clientes_controller.dart';

import 'package:flutter_application_1/controlador/ventasController.dart';
import 'package:flutter_application_1/menus/addventas.dart';
import 'package:get/get.dart';


ClientesController cliente = Get.put(ClientesController());
VentasController control = Get.put(VentasController());

class Ventas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VentasController>
    (
      init: VentasController(),
      builder: (_) => Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Get.to(AddVentas());
        },
        child: Icon(Icons.add,color:Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
      centerTitle: true,
      title: Text("Lista de Ventas"),
      ),
      body: StreamBuilder<QuerySnapshot>
      (
        stream: _.firestore.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if (snapshot.hasError) {
          return Text('A ocurrido un error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
           return Container(
    width: 400,
    padding: new EdgeInsets.all(3.0),

    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      color: Colors.transparent,
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.ballot, size: 50),
            title: Text(document.data()!['Cliente'], style: TextStyle(color: Colors.white, fontSize: 20)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text( "Total:" + document.data()!['Total'], style: TextStyle(color: Colors.white, fontSize: 14)),
                Divider(),
                Text( "Observacion: " + document.data()!['Notas'], style: TextStyle(color: Colors.white, fontSize: 14)),
                Divider(),
                Center(child: Text("Detalles")),
                Divider(),

                Row(
                  children: [
                    Expanded(child: Text(document.data()!['Producto1'], style: TextStyle(color: Colors.white, fontSize: 14))),
                    Text(document.data()!['Cantidad'], style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ],),

              trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                icon: Icon(Icons.delete, color: Colors.red), 
                onPressed: (){
                  mydialog(
                    context,
                    title: "Esta seguro de eliminar?",
                    content: "Borrar " + document.data()!['Cliente'],
                    ok: ()async
                    {
                      Get.back();
                      await _.borrarVentas(document.id);
                    }
                    );
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );

          }).toList(),
        );
        }
      )
      ),
      );
  }
}