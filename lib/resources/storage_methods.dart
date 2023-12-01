import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

// Jangan dihapus yang atas

// import 'dart:typed_data';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// import 'package:uuid/uuid.dart';

// class StorageMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

//   Future<String> uploadImageToStorage(
//       String childName, Uint8List file, bool isPost) async {
//     Reference ref =
//         _storage.ref().child(childName).child(_auth.currentUser!.uid);
//     if (isPost) {
//       String id = const Uuid().v1();
//       ref = ref.child(id);
//     }

//     UploadTask uploadTask = ref.putData(file);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

  Future<List<Map<String, dynamic>>> searchItems(String query) async {
    try {
      // Convert the search query to lowercase for case-insensitive search
      String lowercaseQuery = query.toLowerCase();

      // Query Firestore to find items containing the query in 'deskripsi' field
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('posts')
          .where(
            'deskripsi',
            arrayContains: lowercaseQuery,
          )
          .get();

      List<Map<String, dynamic>> filteredItems =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      return filteredItems;
    } catch (e) {
      print("Error searching items: $e");
      return [];
    }
  }

// }
}
