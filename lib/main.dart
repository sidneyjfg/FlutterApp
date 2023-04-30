// ignore_for_file: avoid_print

import 'dart:core';

import 'package:cprv_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/autentication_page.dart';
import 'pages/home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AutenticationPage(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool saved = false;//verifica se foi salvo as credenciais do usuário na tela
  bool hide = true;//variável utilizada para servir de parametro para esconder/mostrar senha
  final _emailController = TextEditingController();//variável necessária para passamos de parâmetro ao controller nos "input"(caixa de texto)
  final _passwordController = TextEditingController();//mesmo coisa so que pra senha
  final _fireBaseAuth = FirebaseAuth.instance;//instancia o firebase no projeto a fim de usar suas funcionalidades
  //mas antes de usar o firebase é necessário baixar os pacotes do firebase.
  final _formKeyEmail = GlobalKey<FormState>();//criado a fim de criar uma chave pro formulário na sessao de email.

  //antes do override deve ser feito a iniciação das variáveis
  @override
  Widget build(BuildContext context) {
    return WillPopScope(//funçao para não retornar pelo botão do propro device
      onWillPop: () async {
        if (!saved) {//se n tiver salvo os dados do usuario
          return false;//retorna falso e a pessoa nao consegue, depois de desconectar da aplicação, clicar no botão de voltar
        }
        return true;
      },
      child: Scaffold(//aqui é o inicio da construção de tela
        backgroundColor: const Color.fromRGBO(34, 61, 115, 45),//define uma cor de fundo
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(//Cria um container definindo margens altura e larguras
                margin: const EdgeInsets.only(top: 400),
                width: double.infinity,
                height: 450,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),//defino borda direita superior
                        topLeft: Radius.circular(40),//defino borda esquerda superior
                    )),
              ),
              Container(//container central de login
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.only(top: 200, left: 50, right: 50),
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 0.1,
                          blurRadius: 5)
                    ]),
                child: Column(//colunas para criação do formulário composto de email e senha
                  children: [
                    Form(
                      key: _formKeyEmail,//chave igual havia mostrado no inicio
                      child: TextField(
                        controller: _emailController,//passo como parâmetro oque o usuario digitar pra _emailController
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,//passo oque o usuario digita para o a variável em roxo
                      obscureText: hide,//defino hide para obscureText que nada mais é que a ocultação da senha int ela inicia como true de padrao;
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {//quando clicado no ícone de mostrar senha
                            setState(() {
                              hide = !hide;//setamos seu estado para false logo ela deixa de esconder
                            });
                          },
                          icon: hide//passo como parâmetro ao "icon" o hide que por sua vez é boleano para fazer a alteração de icone
                              ? const Icon(Icons.visibility_off)//consição se for verdadeiro
                              : const Icon(Icons.visibility),// condição se for falso
                        ),
                        prefixIcon: const Icon(Icons.lock),//prefixIcon significa um icone antes de tudo (icone de cadeado)
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(//"botão" esqueceu a senha que é somente texto.
                        onPressed: () {
                          forgetPassword();//chama a função em questão
                        },
                        child: const Text("Esqueceu sua senha?"),
                      ),
                    ),
                    ElevatedButton(//de fato um botão mas agora de login
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(250, 163, 65, 100),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100)),
                        onPressed: () {
                          saved = true;//ao clicar mudo o saved para true que ai deixa salvo ate o final da aplicação de que foi feito a conexão anteriormente
                          login();//chama a função em questao
                        },
                        child: const Text("Login")),
                  ],
                ),
              ),
              Positioned(//posicionamos uma logo da CPRV no meio/topo da pagina
                  top: 20,
                  left: 95,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logoCPRV.png'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  forgetPassword() async {
    if (_emailController.text.isNotEmpty) {
      _formKeyEmail.currentState!.reset();
      if (_formKeyEmail.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email de redefinição enviado com Sucesso!')));
        _fireBaseAuth
            .sendPasswordResetEmail(email: _emailController.text)
            .then((value) => {print('Email enviado com Sucesso!')})
            // ignore: invalid_return_type_for_catch_error
            .catchError((e) => print(e.toString()));
      }
    } else {
      const ScaffoldMessenger(
        child: Text('Informe um email Válido!'),
      );
    }
  }

  login() async {
    try {
      UserCredential userCredential =
          await _fireBaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário não encontrado!')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha Incorreta!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Usuário não encontrado! Tente novamente')));
      }
    }
  }
}//fechamento do State<LoginScreen>
