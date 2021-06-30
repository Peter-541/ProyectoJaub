import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'DataBase.dart';
import 'Services.dart';
import 'Integrantes.dart';
import 'package:google_fonts/google_fonts.dart';


class DataTableDemo extends StatefulWidget {
  //
  DataTableDemo() : super();

  final String title = 'Vuelos del Dia';

  @override
  DataTableDemoState createState() => DataTableDemoState();
}


class Debouncer{
  final int millisecounds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.millisecounds});
  run(VoidCallback action){
    if(null != _timer){
      _timer.cancel();//cuando el usuario escribe continuamente, esto cancela el temporizador
    }

// luego iniciaremos un nuevo temporizador buscando que el usuario se detenga
    _timer = Timer(Duration(microseconds: millisecounds), action);
  }
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Vuelo> _vuelos;

  List<Vuelo> _filterVuelo;
  GlobalKey<ScaffoldState> _scaffoldKey;

  TextEditingController _origenVController;
  TextEditingController _destinoVController;
  TextEditingController _salidaVController;
  Vuelo _selectedVuelo;
  bool _isUpdating;
  String _titleProgress;

  final _debouncer = Debouncer(millisecounds: 200);
  //Lets increase the time to wait and search to 2 seconds


  @override
  void initState() {
    super.initState();
    _vuelos = [];
    _filterVuelo = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); //Clave para obtener el contexto para mostrar una SnackBar
    _origenVController = TextEditingController();
    _destinoVController = TextEditingController();
    _salidaVController = TextEditingController();
    _getVuelos();
  }

  // Método para actualizar el título en el título de la barra de aplicaciones
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable() {
    _showProgress('Creando Tabla...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }


  _addVuelo() {
    if (_origenVController.text.isEmpty || _destinoVController.text.isEmpty || _salidaVController.text.isEmpty) {
      print('Campos Vacios');
      return;
    }
    _showProgress('Añadiendo Vuelo...');
    Services.addVuelo(_origenVController.text, _destinoVController.text, _salidaVController.text )
        .then((result) {
      if ('success' == result) {
        _getVuelos();
// Actualizar la lista después de agregar ..
        _clearValues();
      }
    });
  }

  _getVuelos() {
    _showProgress('Cargando Vuelos...');
    Services.getVuelos().then((vuelos) {
      setState(() {
        _vuelos = vuelos;
// Inicializa ti la lista del servidor al recargar ...
        _filterVuelo = vuelos;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${vuelos.length}");
    });
  }

  _updateVuelo(Vuelo vuelo) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Vuelo...');
    Services.updateVuelo(
        vuelo.id, _origenVController.text, _destinoVController.text, _salidaVController.text)
        .then((result) {
      if ('success' == result) {
        _getVuelos(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteVuelo(Vuelo vuelo) {
    _showProgress('Eliminando Vuelo...');
    Services.deleteVuelo(vuelo.id).then((result) {
      if ('success' == result) {
        _getVuelos(); // Refresh after delete...
      }
    });
  }

  //
  // Método para borrar los valores de TextField
  _clearValues() {
    _origenVController.text = '';
    _destinoVController.text = '';
    _salidaVController.text = '';
  }

  _showValues(Vuelo vuelo) {
    _origenVController.text = vuelo.origenV;
    _destinoVController.text = vuelo.destinoV;
    _salidaVController.text = vuelo.salidaV;
  }


// Creemos una DataTable y mostremos la lista de empleados en ella.
  SingleChildScrollView _dataBody() {

// Vista de desplazamiento vertical y horizontal para la tabla de datos
    // desplaza tanto Vertical como Horizontal ...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('ORIGEN'),
            ),
            DataColumn(
              label: Text('DESTINO'),
            ),
            DataColumn(
              label: Text('HORA S'),
            ),

// Vamos a agregar una columna más para mostrar un botón de eliminar
            DataColumn(
              label: Text('ELIMINAR'),
            )
          ],
          // La lista debería mostrar la lista filtrada ahora
          rows: _filterVuelo
              .map(
                (vuelo) => DataRow(cells: [
              DataCell(
                Text(vuelo.id),
                // Agregue tap en la fila y complete el
                // campos de texto con los valores correspondientes para actualizar
                onTap: () {
                  _showValues(vuelo);
                  // Establecer la empleada seleccionada para actualizar
                  _selectedVuelo = vuelo;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  vuelo.origenV.toUpperCase(),
                ),
                onTap: () {
                  _showValues(vuelo);
                  // Establecer la empleada seleccionada para actualizar
                  _selectedVuelo = vuelo;
                  // Establecer la actualización de la bandera en verdadero para indicar en el modo de actualización
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  vuelo.destinoV.toUpperCase(),
                ),
                onTap: () {
                  _showValues(vuelo);
                  // Establecer la empleada seleccionada para actualizar
                  _selectedVuelo = vuelo;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
                  DataCell(
                    Text(
                      vuelo.salidaV.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(vuelo);
                      // Establecer la empleada seleccionada para actualizar
                      _selectedVuelo = vuelo;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
              DataCell(IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  _deleteVuelo(vuelo);
                },
              ))
            ]),
          )
              .toList(),
        ),
      ),
    );
  }

  searchField(){
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Filtrado',
        ),
        onChanged: (string){
          // comenzaremos a filtrar cuando el usuario escriba en el campo de texto
          // Ejecutar el antirrebote y la búsqueda de estrellas
          _debouncer.run(() {
            setState(() {
              _filterVuelo = _vuelos.where((u) => (u.origenV.toLowerCase().contains(string.toLowerCase()) ||
                  u.destinoV.toLowerCase().contains(string.toLowerCase()))).toList();
            });
          });
        },
      ),
    );
  }




  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
// mostramos el progreso en el título ...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline), onPressed: ()  => Navigator.push(context, MaterialPageRoute(builder: (context) => Integrantes())),

          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh_sharp),
            onPressed: () {
              _getVuelos();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _origenVController,
                decoration: InputDecoration.collapsed(
                  hintText: 'ORIGEN',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _destinoVController,
                decoration: InputDecoration.collapsed(
                  hintText: 'DESTINO',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _salidaVController,
                decoration: InputDecoration.collapsed(
                  hintText: 'HORA SALIDA',
                ),
              ),
            ),
            // Agregar un botón de actualización y un botón Cancelar
            // mostrar estos botones solo al actualizar un empleado
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),
                  onPressed: () {
                    _updateVuelo(_selectedVuelo);
                  },
                ),
                OutlineButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
                : Container(),
            searchField(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addVuelo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}