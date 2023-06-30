import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geoplaceflutter/firebase_options.dart';

import 'mock.dart';

void main(){

  setupFirebaseAuthMocks();

  setUpAll(() async {
    
      await Firebase.initializeApp();
    
  });


  test('Teste de login firebase', () {
      
      final FirebaseAuth auth = FirebaseAuth.instance;

      final user = auth.signInWithEmailAndPassword(
        email: 'teste@teste.com',
        password: '123456'
      );

      expect(user, isNotNull);

  });

}