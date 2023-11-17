import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sound_trends/utils/const.dart' as cons;
import 'package:sound_trends/views/home.dart';
import 'package:sound_trends/views/stats.dart';

class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => _userState();
}

//Icono en la aplicacion que se vea bien

class _userState extends State<user> {
   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(

      home: Scaffold(
        backgroundColor: cons.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search, color: cons.white),
                          onPressed: () {
                            // Acción al hacer clic 
                          },
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(color: cons.white, fontSize: 20),
                        ),
                        IconButton(
                          icon: Icon(Icons.person, color: cons.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const user()));
                          },
                        ),

                      ],
                    ),
SizedBox(width: size.width*1,
height: size.height*0.04),
            CircleAvatar(
              radius: size.width*0.15,
              backgroundImage: AssetImage('assets/profile_image.jpg'), // Reemplaza con tu imagen de perfil
            ),
             SizedBox(height: size.height * 0.02),
                      SizedBox(height: 20),

            // Nombre de usuario
            Text(
              'Username',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Información del perfil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'alguien@example.com',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 20),

            // Botones de acciones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    // Acción al presionar el botón "Seguir"
                  },
                  child: Text('Change theme',style: TextStyle(color: cons.white),),
                  
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    // Acción al presionar el botón "Mensaje"
                  },
                  child: Text('Friend List',style: TextStyle(color: cons.white)),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Detalles adicionales o estadísticas
            ],

          ),
        ),


      ),
    );
  }
}