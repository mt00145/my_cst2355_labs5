import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_cst2355_labs/DataRepository.dart';


class ProfilePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});

  // final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _controllerFirstName;
  late TextEditingController _controllerLastName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;
  EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
  var password = "";
  var imageSource = "images/question-mark.png";
  var yesPressed = false;
  var noPressed = false;

  @override
  void initState() {
    super.initState();
    _controllerFirstName = TextEditingController();
    _controllerLastName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();
    getSharedPreferences();
  }

  void getSharedPreferences() async { // this function has a thread in it
    //write this:
    // EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    // var login = await prefs.getString("Login"); //returns a Future<String>, not string
    // var password = await prefs.getString("Password"); //returns a Future<String>, not string
    //
    // if(login != ""){
    //   _controllerLogin.text = login;
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Loaded saved login')),
    //     );
    //   });
    // }
    // if(password != ""){
    //   _controllerPassword.text = password;
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Loaded saved password')),
    //     );
    //   });
    // }


    //Or you can write:, does not need async function
    // prefs.getString("Login").then( (str) {   if(str != null) {  _controllerLogin.text = str; }   });
  }

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }


  void _loadData() async {
    await DataRepository.loadProfile();
    setState(() {
      _controllerFirstName.text = DataRepository.firstName;
      _controllerLastName.text = DataRepository.lastName;
      _controllerPhone.text = DataRepository.phone;
      _controllerEmail.text = DataRepository.email;
    });
  }

  void _saveData() async {
    DataRepository.firstName = _controllerFirstName.text;
    DataRepository.lastName = _controllerLastName.text;
    DataRepository.phone = _controllerPhone.text;
    DataRepository.email = _controllerEmail.text;
    await DataRepository.saveProfile();
  }


  void _launchDialer(String number) {
    canLaunch("tel:${_controllerPhone.text}").then(
            (itCan) {

          if(itCan)
          {
            launch("tel:${_controllerPhone.text}");
          }
          else
          {
            var Snackbar;
            Snackbar.messenger("You can't make phone calls from this device");
          }
        }
    );
  }

  void _launchSMS(String number) {
    canLaunch("sms:${_controllerPhone.text}").then(
            (itCan) {

          if(itCan)
          {
            launch("sms:${_controllerPhone.text}");
          }
          else
          {
            var Snackbar;
            Snackbar.messenger("You can't send SMS from this device");
          }
        }
    );
  }

  void _launchEmail(String email) {
    canLaunch("mailto:${_controllerEmail.text}").then(
            (itCan) {

          if(itCan)
          {
            launch("mailto:${_controllerEmail.text}");
          }
          else
          {
            var Snackbar;
            Snackbar.messenger("You can't send emails from this device");
          }
        }
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controllerFirstName,
                decoration: InputDecoration(
                    hintText:"First Name",
                    border: OutlineInputBorder()
                )),//Login Name Text Field
            TextField(controller: _controllerLastName,
                decoration: InputDecoration(
                  hintText:"Last Name",
                  border: OutlineInputBorder(),
                )),//Password Text Field
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(child:
                    TextField(controller: _controllerPhone,
                        decoration: InputDecoration(
                          hintText:"Phone Number",
                          border: OutlineInputBorder(),
                        ),
                    ),//Password Text Field
                  ),
                  ElevatedButton(
                    onPressed: () => _launchDialer(_controllerPhone.text),
                    child: Icon(Icons.phone),
                  ),
                  ElevatedButton(
                    onPressed: () => _launchSMS(_controllerPhone.text),
                    child: Icon(Icons.sms),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(child:
                    TextField(controller: _controllerEmail,
                      decoration: InputDecoration(
                        hintText:"Email Address",
                        border: OutlineInputBorder(),
                      )),//Password Text Field
                  ),
                  ElevatedButton(
                    onPressed: () => _launchEmail(_controllerEmail.text),
                    child: Icon(Icons.email),
                  ),
                ]
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: Text("Save"),
            ),
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
