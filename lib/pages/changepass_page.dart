// ignore_for_file: avoid_print

import 'package:cprv_app/pages/autentication_page.dart';
import 'package:cprv_app/pages/home_page.dart';
import 'package:cprv_app/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final _password = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmpassword = TextEditingController();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKeyNewPass = GlobalKey<FormState>();
  final _formKeyNewPass2 = GlobalKey<FormState>();
  bool hide = true;
  bool hide2 = true;
  bool hide3 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
          centerTitle: true,
          title: Text(
            "Redefinição de Senha",
            style: Theme.of(context).textTheme.headlineSmall,
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
                    color: const Color.fromRGBO(115, 140, 191, 75),
                  ),
                ),

                TextButton(
                  onPressed: () {},
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
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Form(
                  key: _formKeyPass,
                  child: TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.text,
                    obscureText: hide,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Senha incorreta')));
                      } else {
                        return null;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Senha Atual",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            hide ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKeyNewPass,
                  child: TextFormField(
                    controller: _newpassword,
                    keyboardType: TextInputType.text,
                    obscureText: hide2,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        return "Senha inválida";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Nova Senha",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              hide2 = !hide2;
                            });
                          },
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            hide2 ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKeyNewPass2,
                  child: TextFormField(
                    controller: _confirmpassword,
                    keyboardType: TextInputType.text,
                    obscureText: hide3,
                    validator: (text) {
                      if ((text!.isEmpty || text.length < 6) ||
                          _newpassword.text != _confirmpassword.text) {
                        return 'As senhas não coincidem';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Repita a nova senha",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              hide3 = !hide3;
                            });
                          },
                          icon: Icon(
                            hide3 ? Icons.visibility_off : Icons.visibility,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      colors: [Color(0xFF6a7bd9), Color(0xff3f51b5)],
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight),
                ),
                child: TextButton(
                  onPressed: () {
                    changeData();
                  },
                  child: const Text(
                    "Atualizar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        )));
  }

  exit() async {
    final firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((user) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AutenticationPage())));
  }

  changeData() async {
    if (_formKeyPass.currentState!.validate() &&
        _formKeyNewPass.currentState!.validate() &&
        _formKeyNewPass2.currentState!.validate() &&
        _newpassword != _confirmpassword) {
      // Att Senha
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email.toString(), password: _password.text);
      user.reauthenticateWithCredential(credential).then((value) {
        user
            .updatePassword(_newpassword.text)
            .then((value) => print("Senha atualizada com sucesso!"))
            .catchError((e) => print(e.toString()));
        // ignore: invalid_return_type_for_catch_error
      }).catchError((e) => print('Senha atual Incorreta'));
    }
  }
}
