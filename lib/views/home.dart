import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sound_trends/utils/const.dart' as cons;
import 'package:sound_trends/views/overview.dart';
import 'package:sound_trends/views/stats.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _registroState();
}

//Icono en la aplicacion que se vea bien

class _registroState extends State<home> {
   @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: cons.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.80,
                      child: Row(
                        children: [
                          Text('Welcome,', style: TextStyle(color: cons.white, fontSize: 40, fontWeight: FontWeight.w900)),
                          Text(' User', style: TextStyle(color: cons.green, fontSize: 40, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.80,
                      child: Row(
                        children: [
                          Text('Your ', style: TextStyle(color: cons.white, fontSize: 40, fontWeight: FontWeight.w900)),
                          Text('Weekly', style: TextStyle(color: cons.green, fontSize: 40, decoration: TextDecoration.underline, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.80,
                      child: Text('Stats', style: TextStyle(color: cons.white, fontSize: 40, fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.80,
                child: Text('Your top artists.', style: TextStyle(color: cons.white, fontSize: 35)),
              ),
              SizedBox(height: 20,),
              Container(
                width: size.width * 0.80,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: cons.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.3, // Puedes ajustar este valor según tus necesidades
                      height: size.height * 0.13,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/natael.jpeg'),
                        radius: 50,
                      ),
                    ),
                    Container(
                      width: size.width * 0.3, // Puedes ajustar este valor según tus necesidades
                      height: size.height * 0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Natael Cano', style: TextStyle(color: cons.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.80,
                child: Text('Your top sounds.', style: TextStyle(color: cons.white, fontSize: 35)),
              ),
              SizedBox(height: 20,),
              Container(
                width: size.width * 0.80,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: cons.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.3, // Puedes ajustar este valor según tus necesidades
                      height: size.height * 0.13,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/alien_boy.jpg'),
                        radius: 50,
                      ),
                    ),
                    Container(
                      width: size.width * 0.3, // Puedes ajustar este valor según tus necesidades
                      height: size.height * 0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Alien Boy', style: TextStyle(color: cons.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.80,
                child: Text('Your top PlayLists.', style: TextStyle(color: cons.white, fontSize: 35)),
              ),
              SizedBox(height: 20,),
              Container(
                width: size.width * 0.80,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: cons.green),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.3, // Puedes ajustar este valor según tus necesidades
                      height: size.height * 0.13,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/mia.jpg'),
                        radius: 50,
                      ),
                    ),
                    Container(
                      width: size.width * 0.3, // Puedes ajustar este valor según tus necesidades
                      height: size.height * 0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('By Mia', style: TextStyle(color: cons.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(232, 0, 0, 0),
        selectedItemColor: Color.fromARGB(255, 30, 241, 139),
        unselectedItemColor: Color.fromARGB(165, 241, 239, 239),
        
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.equalizer),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Top',
            
          ),
          /*BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.music_note_sharp),
            label: 'Identity',
          ),*/
          /*BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),*/ 
        ],
        currentIndex: _selectedIndex,
       
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            if(_selectedIndex==0){
            }
            if(_selectedIndex==1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const stats()));
            }
            if(_selectedIndex==2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const top())); 
            }
          });
        },
      ),
      ),
    );
  }
}