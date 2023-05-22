import 'package:flutter/widgets.dart';
import 'package:geoplaceflutter/models/lugar.dart';

class LugarProvider with ChangeNotifier {
  final List<Lugar> itens = [
    Lugar(0, 0, "", "", "", "", "", 0),
  ];
}