import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/inputText.dart';
import '../routes/route_paths.dart';

class LoginCadastroScreen extends StatefulWidget {
  const LoginCadastroScreen({Key? key}) : super(key: key);

  @override
  State<LoginCadastroScreen> createState() => _LoginCadastroScreenState();
}

class _LoginCadastroScreenState extends State<LoginCadastroScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConfirmeController = TextEditingController();

  bool isLoading = false;
  final imgLogin = Lottie.asset("assets/registro.json");
  bool isLoadingImg = true;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
  await Future.delayed(const Duration(seconds: 1)); // Simulando um carregamento assíncrono

  setState(() {
    isLoadingImg = false;
  });
}


  

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;


    Future<void> _cadastrar() async {
      setState(() {
        isLoading = true;
      });
      String email = loginController.text;
      String senha = senhaController.text;
      String senhaConfirma = senhaConfirmeController.text;

      if(senha != senhaConfirma){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Senhas diferente"),
            duration: Duration(seconds: 2),
          ),
        );
        isLoading = false;
        return;
      }

      try {
        final user = await auth.createUserWithEmailAndPassword(email: email, password: senha);
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

    if (auth.currentUser != null) {
      Navigator.pushNamed(context, RoutePaths.HOME);
    }

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue[900],
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
                "Cadastro de Usuário",
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
              InputText(
                labelText: "Confirmar Senha",
                controller: senhaConfirmeController,
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
                          _cadastrar();
                        },
                        child: const Text(
                          "Cadastrar",
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
