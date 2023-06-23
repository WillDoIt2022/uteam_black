import 'package:firebase_auth/firebase_auth.dart';
import '../globals.dart' as globals;


class Auth {
  //Creating new instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
        try {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ); } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future authStateChanges() async {
    bool successfully=false;
     try {
    final user = await _auth.authStateChanges().listen((User? user) {
      //if (user == null||user.emailVerified==false) {
        if (user == null) {
          successfully=false;
        print(user);
        print('User is currently signed out!');
      } else {
        successfully=true;
        print(user);
        // !!!!! Here you know the user is signed-in !!!!!
        print('User is signed in!');

      } 
        //globals.userID=true;
      }
    
  );
return successfully;
  }catch (e) {
      print(e);
    }
  }

Future signOut() async {
    try {
      final user = await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }


}
