import 'package:cprv_app/pages/autentication_page.dart';
import 'package:cprv_app/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cprv_app/icon_button.dart';
import 'package:cprv_app/pages/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final Uri gda = Uri.parse(//passo o link pra variavel;
      'https://app.powerbi.com/view?r=eyJrIjoiZGYyZmZlNGYtZjk5ZS00NWNlLTg4MDgtZDJiYzMyODZhN2U1IiwidCI6IjdjYWI1NzFlLWEyMGUtNDg2Mi1iNWY2LTE3M2I5NjEzMWYxOCJ9');

  final Uri gdo = Uri.parse(
      'https://app.powerbi.com/view?r=eyJrIjoiYzBkMTBkNDUtOWQ3ZC00MjQ3LWIwYTAtYzE5ZDRiNzFlNjViIiwidCI6IjdjYWI1NzFlLWEyMGUtNDg2Mi1iNWY2LTE3M2I5NjEzMWYxOCJ9');

  final Uri pip = Uri.parse(
      'https://app.powerbi.com/view?r=eyJrIjoiYzIwZmJmYjgtMWJlNS00NTlhLWJmMTctODlhNWViMWVkZmZhIiwidCI6IjdjYWI1NzFlLWEyMGUtNDg2Mi1iNWY2LTE3M2I5NjEzMWYxOCJ9');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(34, 61, 115, 45), //azul escuro - fundo da pagina
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
              //
              // a partir daqui começa os botões da navbar
              TextButton(//botão de log-out
                onPressed: () {
                  exit();
                },
                child: Image.asset(
                  'assets/images/log-out.png',
                  height: 60,
                  width: 60,
                ),
              ),
              TextButton(//botão da homepage
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
                  color: const Color.fromRGBO(115, 140, 191, 75),
                ),
              ),

              TextButton(//botão do perfil
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

              TextButton(//botão da página de configurações
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
                child: Image.asset(
                  'assets/images/config.png',
                  height: 60,
                  width: 60,
                ),
              ),
            ], //e termina aqui os botões com imagens
          ),
        ),
      ),
      body: Column(//inicio uma coluna com a logo cprv de fundo com uma opacidade de 0.7
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.7,
                child: Image.asset('assets/images/logoCPRV.png'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 125),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,//criação de um sizebox apenas pra separar o conteúdo
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: ButtonStyle(//botão do GDA
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 8, 37, 202))),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Abrindo GDA Link aguarde...')));

                                  _launchUrlGda();
                                },
                                child: CatigoryW(//esse catigoryW está na pasta components com o nome de info.dart
                                  image: 'assets/images/gda.png',
                                  text: '',
                                  color: const Color.fromRGBO(1, 1, 1, 1),
                                ),
                              ),
                              TextButton(//botão GDO
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Abrindo GDO Link aguarde...')));

                                  _launchUrlGdo();
                                },
                                child: CatigoryW(
                                    image: 'assets/images/gdo.png',
                                    text: '',
                                    color: const Color.fromRGBO(1, 1, 1, 1)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(//botão PIP
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Abrindo PIP Link aguarde...'),
                                    ),
                                  );
                                  _launchUrlPip();
                                },
                                child: CatigoryW(
                                  image: 'assets/images/pip.png',
                                  text: '',
                                  color: const Color.fromRGBO(1, 1, 1, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrlPip() async {
    if (!await launchUrl(pip)) {
      throw Exception('Could not launch $pip');
    }
  }

  Future<void> _launchUrlGda() async {
    if (!await launchUrl(gda)) {
      throw Exception('Could not launch $gda');
    }
  }

  Future<void> _launchUrlGdo() async {
    if (!await launchUrl(gdo)) {
      throw Exception('Could not launch $gdo');
    }
  }

  exit() async {
    await _firebaseAuth.signOut().then((user) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AutenticationPage())));
  }
}
