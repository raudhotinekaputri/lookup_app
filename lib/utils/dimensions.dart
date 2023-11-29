import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookup_app/ui/sidebar.dart';
import 'package:lookup_app/ui/profile.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [

  Sidebar(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];