//import 'dart:html';
import 'package:cprv_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cprv_app/pages/profile_page.dart';
import 'package:cprv_app/pages/autentication_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
        centerTitle: true,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: Container(
        //navbar no rodapé
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: const Color.fromRGBO(34, 61, 115, 45),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //a partir daqui começa os botões da navbar
              TextButton(
                onPressed: () {
                  exit();
                },
                child: Image.asset(
                  'assets/images/log-out.png',
                  height: 60,
                  width: 60,
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: Image.asset(
                  'assets/images/web-house.png',
                  height: 60,
                  width: 60,
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: Image.asset(
                  'assets/images/profile.png',
                  height: 60,
                  width: 60,
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/images/config.png',
                  height: 60,
                  width: 60,
                  color: const Color.fromRGBO(115, 140, 191, 75),
                ),
              ),
            ], //e termina aqui os botões com imagens
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: SizedBox(
          width: 350,
          height: 65,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
                side: BorderSide.none,
                shape: const StadiumBorder()),
            child: SizedBox(
                child: Column(
              children: [
                const Text('Termos de Privacidade'),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  icon: const Icon(Icons.privacy_tip),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  exit() async {
    await _firebaseAuth.signOut().then((user) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AutenticationPage())));
  }
}
