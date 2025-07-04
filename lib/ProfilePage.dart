import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 4 Page'),
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
  EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
  var password = "";
  var imageSource = "images/question-mark.png";
  var yesPressed = false;
  var noPressed = false;

  @override
  void initState() {
    super.initState();
    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
    getSharedPreferences();
  }

  void getSharedPreferences() async { // this function has a thread in it
    //write this:
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    var login = await prefs.getString("Login"); //returns a Future<String>, not string
    var password = await prefs.getString("Password"); //returns a Future<String>, not string

    if(login != ""){
      _controllerLogin.text = login;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loaded saved login')),
        );
      });
    }
    if(password != ""){
      _controllerPassword.text = password;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loaded saved password')),
        );
      });
    }


    //Or you can write:, does not need async function
    // prefs.getString("Login").then( (str) {   if(str != null) {  _controllerLogin.text = str; }   });
  }

  @override
  void dispose() {
    _controllerLogin.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }


  void buttonPressed() async {
    setState(() {
      password = _controllerPassword.value.text;
      if(password=="QWERTY123"){
        imageSource = "images/idea.png";
      } else {
        imageSource = "images/stop.png";
      }
    });
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ALERT'),
        content: const Text('Would you like to save your username and password for the next time?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
              prefs.setString("Login", _controllerLogin.value.text);
              prefs.setString("Password", _controllerPassword.value.text);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
              prefs.clear();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
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
            TextField(controller: _controllerLogin,
                decoration: InputDecoration(
                    hintText:"First Name",
                    border: OutlineInputBorder()
                )),//Login Name Text Field
            TextField(controller: _controllerPassword, obscureText:true,
                decoration: InputDecoration(
                  hintText:"Last Name",
                  border: OutlineInputBorder(),
                )),//Password Text Field
            TextField(controller: _controllerPassword, obscureText:true,
                decoration: InputDecoration(
                  hintText:"Phone Number",
                  border: OutlineInputBorder(),
                )),//Password Text Field
            ElevatedButton(
                onPressed: buttonPressed, //  <--- Lambda function
                child: Text("Login")
            ),
            ElevatedButton(
                onPressed: buttonPressed, //  <--- Lambda function
                child: Text("Login")
            ),
            TextField(controller: _controllerPassword, obscureText:true,
                decoration: InputDecoration(
                  hintText:"Email Address",
                  border: OutlineInputBorder(),
                )),//Password Text Field
            ElevatedButton(
                onPressed: buttonPressed, //  <--- Lambda function
                child: Text("Login")
            ),
            Image.asset(imageSource, width: 200, height:200)
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
