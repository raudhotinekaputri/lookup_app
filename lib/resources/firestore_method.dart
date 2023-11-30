import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/models/post.dart';
import 'package:lookup_app/resources/auth_method.dart';
import 'package:lookup_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      {required Uint8List file,
      required String uid,
      required String username,
      required String judul,
      required String status,
      required String deskripsi,
      required String jenis}) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
          uid: uid,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          judul: judul,
          jenis: jenis,
          status: status,
          deskripsi: deskripsi,
          postId: postId);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updatePost(
      {Uint8List? file,
      String? postUrl,
      required String postId,
      required String uid,
      required String username,
      required String judul,
      required String status,
      required String deskripsi,
      required String jenis}) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl;
      if (file != null) {
        photoUrl =
            await StorageMethods().uploadImageToStorage('posts', file, true);
      } else {
        photoUrl = postUrl!;
      }
      postUrl = photoUrl;
      // creates unique id based on time
      Post post = Post(
          uid: uid,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          judul: judul,
          jenis: jenis,
          status: status,
          deskripsi: deskripsi,
          postId: postId);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateUser({
    Uint8List? file,
    required String uid,
    required String username,
    required String photoUrl,
    required String email,
  }) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String aphotoUrl;
      if (file != null) {
        aphotoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        photoUrl = aphotoUrl;
      } else {
        aphotoUrl = photoUrl;
      }

      // creates unique id based on time
      await AuthMethods().storeUserData(uid, username, photoUrl, email, "no");
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
