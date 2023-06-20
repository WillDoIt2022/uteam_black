import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class Auth {
  //Creating new instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
    String email, String password
  )async{
    final user = await _auth.createUserWithEmailAndPassword(
email:email,
password:password,
    );
  }

  Future<void> signInWithEmailAndPassword(
    String email, String password
  )async{
    final user = await _auth.signInWithEmailAndPassword(
email:email,
password:password,
    );
  }
}