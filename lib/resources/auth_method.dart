import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lookup_app/models/user.dart' as model;
import 'package:lookup_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'photoUrl': photoUrl,
          'email': email,
          'bio': bio,
        });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> storeUserData(
      String uid, String userName, String userPhoto, String email) async {
    final userDocRef = _firestore.collection('users').doc(uid);

    final existingData = await userDocRef.get();

    if (existingData.exists) {
      // Dokumen dengan UID yang sama sudah ada, lakukan pembaruan data
    } else {
      // Dokumen dengan UID yang sama belum ada, buat dokumen baru
      await userDocRef.set({
        'username': userName,
        'uid': uid,
        'photoUrl': userPhoto,
        'email': email,
        'bio': "Default",
      });
    }
  }

  Future<Object> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth!.accessToken,
        idToken: gAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Dapatkan UID dari pengguna yang berhasil login
      String uid = userCredential.user!.uid;
      print('UID pengguna yang login: $uid');

      String userName = gUser!.displayName ?? 'No name';
      String userPhoto = gUser.photoUrl ?? 'No photo';
      String email = gUser.email;

      // Gunakan informasi email sesuai kebutuhan
      print('Email pengguna: $email');

      // Gunakan informasi nama pengguna dan URL foto sesuai kebutuhan
      print('Nama pengguna: $userName');
      print('URL foto: $userPhoto');
      storeUserData(uid, userName, userPhoto, email);

      return userCredential;
    } catch (err) {
      return err.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
