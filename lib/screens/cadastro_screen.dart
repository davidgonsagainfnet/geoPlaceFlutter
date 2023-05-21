import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoplaceflutter/components/alert.dart';
import 'package:geoplaceflutter/models/cep.dart';
import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/services/cep_service.dart';
import 'package:geoplaceflutter/services/lugar_service.dart';

import '../components/inputText.dart';
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

  bool checkConheco = false;
  bool checkQueroConheco = false;
  bool checkEvitar = false;
  int  statusLugar = 0;

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
      if(statusLugar != 0){
        var dados = Lugar(  double.parse(longitudeController.text), 
                          double.parse(latitudeController.text), 
                          cepController.text, 
                          ruaController.text, 
                          cidadeController.text, 
                          estadoController.text, 
                          descricaoController.text, 
                          statusLugar);
        var insertLugar = LugarService();
        insertLugar.insert(dados);
      } else {
        alertCustom(context, "Campo sem valor", "Informe o check de status do lugar.");
      }
      
    } else {
      alertCustom(context, "Campo sem valor", "Existe campos sem valor.");
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
                    InputText(labelText: "Longitude", controller: longitudeController, textInputType: TextInputType.number),
                    const SizedBox(height: 16),
                    InputText(labelText: "Latitude", controller: latitudeController, textInputType: TextInputType.number),
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
                    InputText(labelText: "Rua", controller: ruaController, textInputType: TextInputType.text),
                    const SizedBox(height: 16),
                    InputText(labelText: "Cidade", controller: cidadeController, textInputType: TextInputType.text),
                    const SizedBox(height: 16),
                    InputText(labelText: "Estado", controller: estadoController, textInputType: TextInputType.text),
                    const SizedBox(height: 16),
                    InputText(labelText: "Descrição do Local", controller: descricaoController, textInputType: TextInputType.text),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                              const Text("Conheço"),
                              Switch(
                                value: checkConheco, 
                                activeColor: Colors.green,
                                onChanged: (bool value) {
                                  setState(() {
                                    checkConheco      = value;
                                    checkQueroConheco = false;
                                    checkEvitar       = false;
                                    statusLugar       = 1;  
                                  });
                                } 
                              ),
                          ],
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                          children: [
                              const Text("Quero conheçer"),
                              Switch(
                                value: checkQueroConheco, 
                                activeColor: Colors.blue,
                                onChanged: (bool value) {
                                  setState(() {
                                    checkConheco      = false;
                                    checkQueroConheco = value;
                                    checkEvitar       = false;
                                    statusLugar       = 2;    
                                  });
                                } 
                              ),
                          ],
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                          children: [
                              const Text("Evitar"),
                              Switch(
                                value: checkEvitar, 
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  setState(() {
                                    checkConheco      = false;
                                    checkQueroConheco = false;
                                    checkEvitar       = value;
                                    statusLugar       = 3;  
                                  });
                                } 
                              ),
                          ],
                          ),
                        ],
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
