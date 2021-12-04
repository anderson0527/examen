import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:examen/components/loader_component.dart';
import 'package:examen/home_screen.dart';
import 'package:examen/models/token.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: Text('Examen'),
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _showGoogleLoginButton(),
      ),
    );
  }

  Widget _showGoogleLoginButton() {
    return Center(
      child: ElevatedButton(
        child: Text('Iniciar sesion con Google'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Color(0xFF120E43);
            }
          ),
        ),
        onPressed: () => _loginGoogle(), 
      ),
    );
  }

  void _loginGoogle() async {
    setState(() {
      _showLoader = true;
    });

    var googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    var user = await googleSignIn.signIn();

    Map<String, dynamic> request = {
      'Email': 'andersonolarte262363@correo.itm.edu.co',
      'Id': '1001359378',
      'LoginType': 0,
      'FullName': 'anderson olarte correa'
    };
    await _socialLogin(request);
  }

  Future _socialLogin(Map<String, dynamic> request) async {
    var url = Uri.parse('https://vehicleszulu.azurewebsites.net/api/Account/SocialLogin');
    var bodyRequest = jsonEncode(request);
    var response = await http.post(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      },
      body: bodyRequest,
    );

    setState(() { _showLoader = false; });
    if(response.statusCode >= 400) {
      await showAlertDialog(
        context: context,
        title: 'Error', 
        message: 'El usuario ya inció sesión previamente por email o por otra red social.',
        actions: <AlertDialogAction>[ AlertDialogAction(key: null, label: 'Aceptar'), ]
      );    
      return;
    }

    var body = response.body;
    var decodedJson = jsonDecode(body);
    var token = Token.fromJson(decodedJson);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomeScreen(token: token,)
      )
    );
  }
}
