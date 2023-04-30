import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import '../main.dart';

//OBS!!!!: ESSA TELA É SOMENTE PARA VERIFICAR SE TEM UM USUÁRIO CONECTADO NA APLICAÇÃO EX.: SAIU DO APP E VOLTOU DEPOIS.
//TELA SOMENTE DE VERIFICAÇÃO DE AUTENTICIDADE.
class AutenticationPage extends StatefulWidget {
  const AutenticationPage({Key? key}) : super(key: key);

  @override
  State<AutenticationPage> createState() => _AutenticationPageState();
}

class _AutenticationPageState extends State<AutenticationPage> {
  StreamSubscription? streamSubscription;

  @override
  initState() {
    super.initState();
    streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
