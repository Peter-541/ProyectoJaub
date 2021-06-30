import 'dart:convert';
import 'package:flutter/material.dart';

import 'DataBase.dart';


class Integrantes extends StatefulWidget{
  final String title;
  Integrantes({this.title});
  @override
  _IntegrantesState createState() => _IntegrantesState();
}



class _IntegrantesState extends State<Integrantes> {
  List <Contactos> _personas = [
   Contactos(nombre:'Jonathan',apellido:'Sebastian Lopez',nocontrol:'18690290'),
  Contactos(nombre:'Omar',apellido:'Flores Hernandez',nocontrol:'1869010'),
  Contactos(nombre:'Gamaliel ',apellido:'Balleza Ramos',nocontrol:'18690220'),
  Contactos(nombre:'Alix Yazmin ',apellido:'Perez Castillo',nocontrol:'18690269')
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Integrantes'),
      ),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (context, index) {
          return ListTile(
         onTap:() => Navigator.pushNamed(context, 'cont'),

         title:   Text(_personas[index].nombre + ' '+ _personas[index].apellido),
          subtitle:   Text(_personas[index].nocontrol),
         leading:  Icon(
           Icons.contact_page_outlined,
           color: Colors.black,
           size: 30.0,
         ),
           trailing:  Icon(
              Icons.arrow_right,
            ),

          );
        })
      );
  }
}