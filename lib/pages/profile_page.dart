import 'dart:io';
import 'package:cprv_app/pages/changepass_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cprv_app/pages/settings_page.dart';
import 'package:cprv_app/pages/autentication_page.dart';
import 'package:cprv_app/pages/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _image;
  XFile? imageTempory;
  String? imagepath;
  final _firebaseAuth = FirebaseAuth.instance;
  String email = '';

  @override
  void initState() {
    super.initState();
    getUsuario();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    //conteudo da tela.
    return Scaffold(
      appBar: AppBar(
        //barra superior com a setinha de voltar (appbar)
        backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon((LineAwesomeIcons.angle_left)),
        ),
        centerTitle: true,
        title: Text(
          "Perfil",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: Container(
        //conteudo do navbar
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
      body: SingleChildScrollView(
        // conteúdo central da página
        child: Container(
          padding: const EdgeInsets.all(100),
          child: Column(
            children: [
              imagepath !=
                      null //condição que verifica se tem alguma imagem nos arquivos,
                  //se tiver coloca a imagem ja salva na foto de perfil do usuario
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(imagepath!)),
                      radius: 60,
                    )
                  : SizedBox(
                      //área de perfil (foto e icone de troca de foto)
                      width: 180,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(34, 61, 115, 45),
                            ),
                          ),
                          child: _image != null
                              ? Image.file(File(_image!.path))
                              : const Center(
                                  child: Text('Selecione uma foto'),
                                ),
                        ),
                      ),
                    ),
              IconButton(
                  //icone clicável pra trocar de foto
                  onPressed: () {
                    getpicture();
                  },
                  icon: const Icon(Icons.add_a_photo_outlined)),
              const SizedBox(height: 10),
              Text(email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge), // aqui eu passo o email do usuário autenticado a tela
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      //botão salvar foto selecionada da galeria
                      if (_image != null) {
                        savePicture(_image!.path);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Foto Salva com Sucesso!')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Sem foto selecionada/foto já salva!')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('Salvar foto',
                        style: TextStyle(color: Colors.black)),
                  )),
              Container(padding: const EdgeInsets.all(3)),
              SizedBox(
                  //"container" para o botão para alterar senha
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePassPage())); //muda para tela de mudar senha
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(34, 61, 115, 45),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('Alterar Senha',
                        style: TextStyle(color: Colors.black)),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void getpicture() async {
    //função que pega imagem da galeria e coloca no lugar do perfil OBS.: mas não salva!!
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<String> getUserId() async {
    //pego o UID do usuário, a princípio era para criar pastas separadas de imagens de perfil por UID
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      return usuario.uid;
    } else {
      return '';
    }
  }

  getUsuario() async {
    //função que pega o email do usuário
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        email = usuario.email!;
      });
    }
  }

  exit() async {
    //função de log-out
    await _firebaseAuth.signOut().then((user) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AutenticationPage())));
  }

  void loadImage() async {
    //função que carrega a imagem ai iniciar a tela
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      imagepath = saveImage.getString(getUserId().toString());
    });
  }

  void savePicture(path) async {
    //função que pega a foto selecionada e salva ela usando como parametro o UID do usuario
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString(getUserId().toString(), path);
  }
}
