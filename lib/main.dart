import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_final/DataTableDemo.dart';
import 'DataBase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Services.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Scaffold(

          appBar: AppBar(title: Text('Editor de Vuelos',   style: GoogleFonts.varelaRound(fontSize: 20.0,)),
          ),
          body: SafeArea(
            child: MyApp(),
          ),
        ),

      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool signin = true;

  TextEditingController namectrl, emailctrl, passctrl;

  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(' ', style: GoogleFonts.varelaRound(fontSize: 10.0,)),
            Icon(Icons.airplanemode_on, size: 180,
              color: Colors.deepOrangeAccent,),
            Text(
                'VIAJES JAUB', style: GoogleFonts.varelaRound(fontSize: 20.0,)),


            boxUi(),
          ],
        )
    );
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else
      setState(() {
        signin = true;
      });
  }

 /* void registerUser() async {
    setState(() {
      processing = true;
    });
    var url = "https://flutterselj.000webhostapp.com/flutterproyect/signup.php";
    var data = {
      "email": emailctrl.text,
      "name": namectrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Cuenta Existente") {
      Fluttertoast.showToast(msg: "Cuenta Existente, por favor inicie sesión",
          toastLength: Toast.LENGTH_LONG);
    } else {
      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
            msg: "Cuenta Creada", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "ERROR", toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
  }*/

  void userSignIn() async {
    var ruta = DataTableDemo();

    setState(() {
      processing = true;
    });
    var url = "https://flutterselj.000webhostapp.com/flutterproyect/signin.php";
    var data = {
      "email": emailctrl.text,
      "pass": passctrl.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "No tiene una cuenta") {
      Fluttertoast.showToast(msg: "No tiene una cuenta, crea una",
          toastLength: Toast.LENGTH_SHORT);
    }
    else {
      if (jsonDecode(res.body) == "false") {
        Fluttertoast.showToast(
            msg: "contraseña incorrecta", toastLength: Toast.LENGTH_SHORT);
      }
      else {
        print(jsonDecode(res.body));
        Navigator.push(context, MaterialPageRoute(builder: (context) => ruta));
      }
    }

    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed: () => changeState(),
                  child: Text('Iniciar Sesión',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.amber : Colors.grey,
                      fontSize: 20.0, fontWeight: FontWeight.bold,
                    ),),
                ),

                FlatButton(
                  onPressed: () => changeState(),
                  child: Text('Registro',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.amber : Colors.grey,
                      fontSize: 20, fontWeight: FontWeight.bold,
                    ),),
                ),
              ],
            ),

            signin == true ? signInUi() : signUpUi(),

          ],
        ),
      ),
    );
  }

  Widget signInUi() {
    return Column(
      children: <Widget>[

        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.assignment_ind_outlined,),
              hintText: 'Correo'),
        ),


        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline_rounded,),
              hintText: 'Contraseña'),
        ),

        SizedBox(height: 10.0,),

        MaterialButton(
        //    onPressed: () => userSignIn(),
        //    onPressed: () => _logUser(),

    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DataTableDemo())),
            child: processing == false
                ? Text('Iniciar Sesión',
              style: GoogleFonts.varelaRound(fontSize: 20.0,
                  color: Colors.yellowAccent[700]),)
                : CircularProgressIndicator(backgroundColor: Colors.red,)
        ),

      ],
    );
  }

  Widget signUpUi() {
    return Column(
      children: <Widget>[

        TextField(
          controller: namectrl,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.assignment_ind_outlined,),
              hintText: 'Nombre'),
        ),

        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.assignment_ind_outlined,),
              hintText: 'Correo Electronico'),
        ),


        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline_rounded,),
              hintText: 'Contraseña'),
        ),

        SizedBox(height: 20.0,),

        MaterialButton(
         //  onPressed: () => registerUser(),
            onPressed: () =>  _addUser(),
            child: processing == false
                ? Text('Registrarse',
              style: GoogleFonts.varelaRound(fontSize: 20.0,
                  color: Colors.yellowAccent[700]),)
                : CircularProgressIndicator(backgroundColor: Colors.red)
        ),

      ],
    );
  }


  _addUser() {
    if (emailctrl.text.isEmpty || namectrl.text.isEmpty || passctrl.text.isEmpty) {
      print('Campos Vacios');
      return;
    }

    Services.addUser(namectrl.text, emailctrl.text, passctrl.text )
        .then((result) {
      if ('success' == result) {
        Fluttertoast.showToast(
            msg: "USUARIO REGISTRADO", toastLength: Toast.LENGTH_SHORT);
      }
    //  }
    });
  }



  _logUser() {
    if (emailctrl.text.isEmpty ||  passctrl.text.isEmpty) {
      print('Campos Vacios');
      return;
    }

    Services.logUser( emailctrl.text, passctrl.text )
        .then((result) {
      if ('success' == result) {
       // userSignIn();
        Fluttertoast.showToast(
            msg: "BIENVENIDO", toastLength: Toast.LENGTH_SHORT);
      }
      //  }
    });
  }





}