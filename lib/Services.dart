import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DataBase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_final/DataTableDemo.dart';

class Services {
  static const ROOT = 'https://flutterselj.000webhostapp.com/flutterproyect/vuelo_actions.php';
  static const ROOTU = 'https://flutterselj.000webhostapp.com/flutterproyect/user_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_VUE_ACTION = 'ADD_VUE';
  static const _UPDATE_VUE_ACTION = 'UPDATE_VUE';
  static const _DELETE_VUE_ACTION = 'DELETE_VUE';
  static const _ADD_USE_ACTION = 'ADD_USE';
  static const _LOG_USE_ACTION = 'LOG_USE';


  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Vuelo>> getVuelos() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getVuelos Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Vuelo> list = parseResponse(response.body);
        return list;
      } else {
        return List<Vuelo>();
      }
    } catch (e) {
      return List<
          Vuelo>(); // devuelve una lista vacía en caso de excepción / error
    }
  }

  static List<Vuelo> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Vuelo>((json) => Vuelo.fromJson(json)).toList();
  }


  static Future<String> addVuelo(String origenv, String destinov,
      String salidav) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_VUE_ACTION;
      map['origen_v'] = origenv;
      map['destino_v'] = destinov;
      map['salida_v'] = salidav;
      final response = await http.post(ROOT, body: map);
      print('addVuelo Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Método para actualizar un empleado en la base de datos ...
  static Future<String> updateVuelo(String vueId, String origenv,
      String destinov, String salidav) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_VUE_ACTION;
      map['emp_id'] = vueId;
      map['origen_v'] = origenv;
      map['destino_v'] = destinov;
      map['salida_v'] = salidav;
      final response = await http.post(ROOT, body: map);
      print('updateVuelo Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

// Método para eliminar un empleado de la base de datos ...
  static Future<String> deleteVuelo(String vueId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_VUE_ACTION;
      map['vue_id'] = vueId;
      final response = await http.post(ROOT, body: map);
      print('deleteVuelo Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // devolviendo solo una cadena de "error" para mantener esto simple ...
    }
  }


  static Future<String> addUser(String name, String email, String pass) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USE_ACTION;
      map['name'] = name;
      map['email'] = email;
      map['pass'] = pass;
      final response = await http.post(ROOTU, body: map);
      print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }


  static Future<String> logUser(String email, String pass) async {
    var ruta = DataTableDemo();

      var map = Map<String, dynamic>();
      map['action'] = _LOG_USE_ACTION;
      map['email'] = email;
      map['pass'] = pass;
      final response = await http.post(ROOTU, body: map);
      print('logUser Response: ${response.body}');
      if (jsonDecode(response.body) == "No tiene una cuenta") {
        Fluttertoast.showToast(msg: "No tiene una cuenta, crea una",
            toastLength: Toast.LENGTH_SHORT);
      }
      else {
        if (jsonDecode(response.body) == "false") {
          Fluttertoast.showToast(
              msg: "contraseña incorrecta", toastLength: Toast.LENGTH_SHORT);
        }
        else {
          print(jsonDecode(response.body));
         // Navigator.push(context, MaterialPageRoute(builder: (context) => ruta));
          DataTableDemo();
        }
      }
    }
  }

