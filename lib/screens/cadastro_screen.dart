import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoplaceflutter/models/cep.dart';
import 'package:geoplaceflutter/services/cep_service.dart';

import '../services/formato_cep.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  void _buscaCep(String cep){
      var listCep = CepService();
      Future<Cep> futureCep = listCep.listCep(cep);

      futureCep.then((cep) {
        ruaController.text = cep.logradouro;
        cidadeController.text = cep.localidade;
        estadoController.text = cep.uf;
      }).catchError((error) {
        print('Ocorreu um erro: $error');
      });
  }

  void _validarCampos() {
    if( _formKey.currentState?.validate() == true){
      print("ola");
    }
  }

  @override
  Widget build(BuildContext context) {


    var image = Image.asset(
      "assets/logo.png",
      width: 200,
      height: 200,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Cadastro de Local")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Center(
                child: image,
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: longitudeController,
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Longitude',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: latitudeController,
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: cepController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FormatoCep(),
                      ],
                      onChanged: (value) {
                        if(value.length >= 9){
                            _buscaCep(value);
                        }
                      },
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cep',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: ruaController,
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Rua',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: cidadeController,
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Cidade',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: estadoController,
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descricaoController,
                      validator: (value) {
                        if(value!.isEmpty) return "Campo Obrigatorio";
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Descrição do Local',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validarCampos,
                        child: const Text("Salvar Local"),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
