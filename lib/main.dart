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
                    hintText:"Login",
                    border: OutlineInputBorder()
                )),//Login Name Text Field
            TextField(controller: _controllerPassword, obscureText:true,
                decoration: InputDecoration(
                    hintText:"Password",
                    border: OutlineInputBorder(),
                )),//Password Text Field
            ElevatedButton(
              onPressed: () {  password = _controllerPassword.value.text; }, //  <--- Lambda function
              child:Text("Login"),
            ),
            Image.asset("images/question-mark.png", width: 200, height:200)
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
