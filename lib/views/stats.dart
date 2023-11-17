import 'package:flutter/material.dart';
import 'package:sound_trends/utils/const.dart' as cons;
import 'package:sound_trends/views/home.dart';
import 'package:sound_trends/views/top.dart';
import 'package:sound_trends/views/user.dart';

class stats extends StatefulWidget {
  const stats({super.key});

  @override
  State<stats> createState() => _statsState();
}

class _statsState extends State<stats> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int _selectedIndex = 1;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: cons.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
              Container(
                width: size.width * 0.95,
                height: size.height * 0.08,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          'Stats',
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
                    Text(
                      'Past 4 Weeks',
                      style: TextStyle(color: cons.gray),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                        color: cons.lightblack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              '1,915',
                              style: TextStyle(color: cons.green, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              'Total tracks streamed',
                              style: TextStyle(color: cons.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                        color: cons.lightblack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              '112',
                              style: TextStyle(color: cons.green, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              'Total hours streamed',
                              style: TextStyle(color: cons.white, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: cons.lightblack,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0), 
                      child: Text(
                        'Genres',
                        style: TextStyle(color: cons.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 2), 
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0), 
                      child: Text(
                        'Your top genre is pop, appearing in 69 of your artists',
                        style: TextStyle(color: cons.gray, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
//Poner codigo de la grafica-----------------------------------------------------------------
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.40,
                      decoration: BoxDecoration(
                        color: cons.lightblack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              '73%',
                              style: TextStyle(color: cons.green, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              'Of your tracks are energic',
                              style: TextStyle(color: cons.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.40,
                      decoration: BoxDecoration(
                        color: cons.lightblack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              '64%',
                              style: TextStyle(color: cons.green, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              'Of your tracks are danceable',
                              style: TextStyle(color: cons.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*
                    Container(
                      width: size.width * 0.40,
                      decoration: BoxDecoration(
                        color: cons.lightblack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              '17%',
                              style: TextStyle(color: cons.green, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0), 
                            child: Text(
                              'Of your tracks are lively',
                              style: TextStyle(color: cons.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Acción al hacer clic 
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, 
                            elevation: 0, 
                          ),
                          child: Text(
                            '4 Weeks',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Acción al hacer clic 
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, 
                            elevation: 0, 
                          ),
                          child: Text(
                            '6 Months',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Acción al hacer clic 
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, 
                            elevation: 0, 
                          ),
                          child: Text(
                            'Lifetime',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            
                            // Acción al hacer clic
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, 
                            elevation: 0, 
                          ),
                          icon: Icon(Icons.calendar_today, color: Colors.white),
                          label: Text(''),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const home()));
            }
            if(_selectedIndex==1){
              
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