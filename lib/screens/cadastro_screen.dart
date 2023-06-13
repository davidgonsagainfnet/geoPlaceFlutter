import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoplaceflutter/models/cep.dart';
import 'package:geoplaceflutter/models/lugar.dart';
import 'package:geoplaceflutter/routes/route_paths.dart';
import 'package:geoplaceflutter/services/cep_service.dart';
import 'package:geoplaceflutter/services/lugar_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../components/alert.dart';
import '../components/inputText.dart';
import '../services/formato_cep.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {

  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool checkConheco = false;
  bool checkQueroConheco = false;
  bool checkEvitar = false;
  int  statusLugar = 0;
  String nomeBotao = "Salvar Cadastro";
  bool isInclusao = true;
  String idEdit = "";


  File? imageFile;

  Future<void> pickImage(ImageSource imageSource) async{
    final picker = ImagePicker();
    final pickerImage = await picker.pickImage(
                                              source: imageSource,
                                              imageQuality: 50,
                                              maxWidth: 200, 
                                            );
    if(pickerImage != null){
      setState(() {
        imageFile = File(pickerImage.path);
      });
    }
  }


  void alertCustomPick() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Escolha de captura de imagem"),
          content: const Text("Como deseja capturar a imagem?"),
          actions: [
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.of(context).pop(); // Fechar o alerta
              },
            ),
            TextButton(
              child: const Text('Galeria'),
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.of(context).pop(); // Fechar o alerta
              },
            ),
          ],
        );
      },
    );
  }

 
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
                          statusLugar,
                          "${auth.currentUser?.uid}");
        var servico = LugarService();

        if(isInclusao){
          servico.insert(dados, imageFile);
        } else {
          servico.editar(idEdit, dados, imageFile);
        }
        
        Navigator.pushNamed(context, RoutePaths.LISTALUGAR);
      } else {
        alertCustom(context, "Campo sem valor", "Informe o check de status do lugar.");
      }
      
    } else {
      alertCustom(context, "Campo sem valor", "Existe campos sem valor.");
    }
  }


  void _setaCampos(BuildContext contexto){
    final Lugar? lugar = ModalRoute.of(contexto)!.settings.arguments as Lugar?;

    if(lugar != null){
      longitudeController.text = lugar.longitude.toString();
      latitudeController.text  = lugar.latitude.toString();
      cepController.text = lugar.cep;
      ruaController.text = lugar.rua;
      cidadeController.text = lugar.cidade;
      estadoController.text = lugar.estado;
      descricaoController.text = lugar.descricao;
      statusLugar = lugar.status;
      switch(statusLugar){
        case 1: setState(() {
                  checkConheco      = true;
                  checkQueroConheco = false;
                  checkEvitar       = false;
                });
        break;
        case 2: setState(() {
                  checkConheco      = false;
                  checkQueroConheco = true;
                  checkEvitar       = false;
                });
        break;
        case 3: setState(() {
                  checkConheco      = false;
                  checkQueroConheco = false;
                  checkEvitar       = true;
                });
        break;
      }
      nomeBotao = "Alterar Cadastro";
      isInclusao = false;
      idEdit = lugar.id!;
    }
  }

  @override
  void initState() {
      super.initState();
      
      getLocation().then((value) {
        if(isInclusao){
          longitudeController.text = value.longitude.toString();
          latitudeController.text  = value.latitude.toString();
        }
        
      });
  }


  Future<LocationData> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(!serviceEnabled) Future.value(null);
    }
    permissionGranted = await location.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted != PermissionStatus.granted) Future.value(null);
    }
    locationData = await location.getLocation();
    return locationData;
  }


  @override
  Widget build(BuildContext context) {

    _setaCampos(context);

    final image = Image.asset(
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
                                key: UniqueKey(),
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
                    IconButton(onPressed: () { alertCustomPick(); } , 
                               icon: const Icon(Icons.camera)
                    ),
                    
                    imageFile != null ? Image.file(imageFile!) : const Icon(Icons.no_photography),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _validarCampos,
                        child: Text(nomeBotao),
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
