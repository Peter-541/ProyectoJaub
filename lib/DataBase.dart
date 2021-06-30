class Vuelo {
  String id;
  String origenV;
  String destinoV;
  String salidaV;

  Vuelo({this.id, this.origenV, this.destinoV, this.salidaV});

  factory Vuelo.fromJson(Map<String, dynamic> json) {
    return Vuelo(
      id: json['id'] as String,
      origenV: json['origen_v'] as String,
      destinoV: json['destino_v'] as String,
      salidaV: json['salida_v'] as String,
    );
  }
}

class User {
  String id;
  String name;
  String email;
  String pass;

  User({this.id, this.name, this.email, this.pass});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      pass: json['pass'] as String,
    );
  }
}


class Contactos {

  final String nombre;
  final String apellido;
  final String nocontrol;

  Contactos ({this.nombre, this.apellido, this.nocontrol});
}
