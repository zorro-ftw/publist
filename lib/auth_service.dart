import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:string_validator/string_validator.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(email, password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logout() => _auth.signOut();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken;
      final facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      return await _auth.signInWithCredential(facebookAuthCredential);
    }
  }
}

class EmailValidator {
  static String validate(String email) {
    if (email == null || email.isEmpty) {
      return "Email can't be empty!";
    } else if (!isEmail(email)) {
      return "Not a valid e-mail!";
    }
    return null;
  }
}

class NameValidator {
  static String validate(String name) {
    if (name == null || name.isEmpty) {
      return "Name can't be empty!";
    } else if (name.length < 3) {
      return "Name can't be shorter than 3 characters!";
    } else if (name.length > 20) {
      return "Name can't be longer than 20 characters!";
    } else if (!isAlpha(name[0])) {
      return "First character of a name must be a letter!";
    } else if (!isAlphanumeric(name)) {
      return "Name must be letters only!";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value, value2) {
    if (value == null || value.isEmpty) {
      return "Şifre Boş Olamaz!";
    }
    if (value2 != value) {
      return "Şifreler Eşleşmiyor!";
    }
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~,.]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Password must contain at least 8 characters, a letter, number and special character!";
    }
    return null;
  }
}
