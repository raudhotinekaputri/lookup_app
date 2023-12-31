import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String judul;
  final String postUrl;
  final String status;
  final String deskripsi;
  final String username;
  final String uid;
  final DateTime datePublished;
  final String jenis;
  final String postId;

  const Post({
    required this.postUrl,
    required this.username,
    required this.uid,
    required this.datePublished,
    required this.judul,
    required this.status,
    required this.deskripsi,
    required this.jenis,
    required this.postId,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      postId: snapshot["postId"],
      username: snapshot["username"],
      uid: snapshot["uid"],
      postUrl: snapshot["postUrl"],
      datePublished: snapshot["datePublished"],
      judul: snapshot["judul"],
      status: snapshot["status"],
      jenis: snapshot["jenis"],
      deskripsi: snapshot["deskripsi"],
    );
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "username": username,
        "uid": uid,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "judul": judul,
        "jenis": jenis,
        "status": status,
        "deskripsi": deskripsi,
      };
}
