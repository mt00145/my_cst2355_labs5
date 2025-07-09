import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



late TextEditingController _controller;
EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

@override
void initState() {
  super.initState();
  _controller = inputController();
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> words =  [] ;
  //or with type inference:
  var wordsArray = <String>[ ];

  Widget ListPage(){
    return Column( children:[
      Expanded(child:
      ListView.builder( itemCount:words.length,
          itemBuilder: (context, rowNum) {  return
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[

                ]);
          }
      )
      )
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[
              ElevatedButton( child:Text("Add item"), onPressed:() {  }  ),
              TextField(inputController: _controller )
            ])
          ],
        ),
      ),
    );
  }
}

