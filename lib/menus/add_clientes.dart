import 'package:flutter/material.dart';

import 'package:flutter_application_1/Data/Database.dart';
import 'package:flutter_application_1/controlador/addClientes_Controller.dart';
import 'package:get/state_manager.dart';


@override
void initstate()
{
}


class AddClientes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddClientesController>
    (
      init:AddClientesController(),
    builder: (_)=>Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Agregar Clientes"),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        TextFormField(
          controller: _.nombreAdd,
          cursorColor: Theme.of(context).accentColor,
          maxLength: 50,
          decoration: InputDecoration(
            labelText: 'Nombre del cliente',
            suffixIcon: Icon(
              Icons.check_circle,
            ),
          ),
        ),
        TextFormField(
          controller: _.direccionAdd,
          cursorColor: Theme.of(context).accentColor,
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Direccion',
            helperText: 'Coloque la direccion ',
            suffixIcon: Icon(
              Icons.check_circle
            ),
          ),
        ),
        TextFormField(
          controller: _.telefonoAdd,
          cursorColor: Theme.of(context).accentColor,
          maxLength: 8,
          validator: (str)
          {
            // ignore: unnecessary_statements
            str!.length < 8 ? "Debe ser 8 digitos" : null;
          },
          decoration: InputDecoration(
            labelText: 'Telefono ',
            helperText: 'Agregar el telefono',
            suffixIcon: Icon(
              Icons.check_circle
            ),
          ),
        ),
        TextFormField(
          controller: _.cuentaAdd,
          cursorColor: Theme.of(context).accentColor,
          maxLength: 25,
          decoration: InputDecoration(
            labelText: 'No de Cuenta',
            helperText: 'No de cuenta (opcional)',
            suffixIcon: Icon(
              Icons.check_circle
            ),
          ),
        ),
        ElevatedButton(
          child: Text("Agregar Cliente"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () {
            DataBase().agregarCliente(_.nombreAdd.text.trim(), _.direccionAdd.text.trim(), _.telefonoAdd.text.trim(), _.cuentaAdd.text.trim());
            _.vaciarText();
          })
      ]),
      ),
    ),
    );
  }
}

