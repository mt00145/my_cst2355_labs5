import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 2 Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controllerLogin;
  late TextEditingController _controllerPassword;
  var password = "";
  var imageSource = "images/question-mark.jpg";

  @override
  void initState() {
    super.initState();
    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerLogin.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }


  void changeImage() {
    setState(() {
      password = _controllerPassword.value.text;
      if(password=="QWERTY123"){
        imageSource = "images/idea.png";
      } else {
        imageSource = "images/stop.png";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("BROWSE CATEGORIES", style: TextStyle(fontSize: 30.0),),
            Text("Not sure exactly about what you're looking for? Do a search, or dive into our most popular "
                "categories.", style: TextStyle(fontSize: 20.0)),
            Text("BY MEAT", style: TextStyle(fontSize: 30.0),),
            Row(  children: [
              Stack(
                  children: <Widget>[
                    Image.asset("images/beef.jpg"),
                    Text("BEEF", style: TextStyle(fontSize: 30.0, backgroundColor:Colors.transparent, color: Colors.white.withOpacity(0.8) ),)
                  ]),
              Icon(Icons.star), Text("1 stick [8 TBSP] Unsalted butter")
            ] ),

            Text("BY COURSE", style: TextStyle(fontSize: 30.0),),


            Text("BY DESSERT", style: TextStyle(fontSize: 30.0),),



          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
