import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

abstract class RepositoryLugar{
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _baseUrlLugar = "https://geoplaceflutter-default-rtdb.firebaseio.com/";
  final String _resource;

  RepositoryLugar(this._resource);

  Future<QuerySnapshot<Map<String, dynamic>>> list() {
    return db.collection(_resource).where('idUser', isEqualTo: auth.currentUser?.uid).get();
  }

  Future<DocumentReference<Map<String, dynamic>>> insert(Map<String, dynamic> data) {
    return db.collection(_resource).add(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> show(String id){
    return db.collection(_resource).doc(id).get();
  }

  Future<void> update(String id, Map<String, dynamic> data){
    return db.collection(_resource).doc(id).set(data);
  }

  Future<void> delete(String id){
    return db.collection(_resource).doc(id).delete();
  }

}