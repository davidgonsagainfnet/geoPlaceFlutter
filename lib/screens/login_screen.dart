import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/inputText.dart';
import '../routes/route_paths.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  bool isLoading = false;
  final imgLogin = Lottie.asset("assets/login.json");
  bool isLoadingImg = true;

  @override
  void initState() {
    super.initState();
    loadImage();
    _bloqueio();
  }

  void loadImage() async {
  await Future.delayed(const Duration(seconds: 1)); // Simulando um carregamento assíncrono

  setState(() {
    isLoadingImg = false;
  });
}

  void _cadastroLogin() {
    Navigator.pushNamed(context, RoutePaths.CADASTROLOGIN);
  }

  void _bloqueio() {
    if(auth.currentUser != null){
      Navigator.pushNamed(context, RoutePaths.HOME);
    }
  }

  Future<void> _esqueci() async {
      if(loginController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Informe um email, para enviarmos as informações de recuperação de senha"),
              duration: Duration(seconds: 3),
            ),
          );
        return;
      }
      
      try{
        await auth.sendPasswordResetEmail(email: loginController.text);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Acesso o email ${loginController.text} para recuperar sua senha."),
              duration: const Duration(seconds: 3),
            ),
          );
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$e"),
              duration: const Duration(seconds: 3),
            ),
          );
      }
      
    }

    Future<void> login() async {
      setState(() {
        isLoading = true;
      });
      String email = loginController.text;
      String senha = senhaController.text;
      try {
        final user = await auth.signInWithEmailAndPassword(
          email: email,
          password: senha,
        );
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RoutePaths.HOME);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$e"),
            duration: const Duration(seconds: 2),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 24),
                child: isLoadingImg
                        ? const CircularProgressIndicator()
                        : imgLogin,
              ),
              const Text(
                "Autenticação",
                style: TextStyle(
                  fontSize: 32,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              InputText(
                labelText: "Email",
                controller: loginController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              InputText(
                labelText: "Senha",
                controller: senhaController,
                textInputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text(
                          "Logar",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple
                        ),
                        onPressed: () {
                          _esqueci();
                        },
                        child: const Text(
                          "Esqueci minha senha",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[300]
                        ),
                        onPressed: () {
                          _cadastroLogin();
                        },
                        child: const Text(
                          "Cadastrar novo usuario",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


