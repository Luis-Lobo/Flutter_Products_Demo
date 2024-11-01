import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:go_router/go_router.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  AuthenticationRepositoryImpl();

  @override
  Future<void> registerUser({required String name, required String email, required String password, required File? image}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    if (image != null) {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference file = storage.ref().child(uid).child(imageName);

      UploadTask uploadTask = file.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      String photoUrl = await taskSnapshot.ref.getDownloadURL();

      await firestore.collection('users').doc(uid).set({'name': name, 'email': email, 'photoUrl': photoUrl});
    } else {
      await firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
      });
    }
  }

  @override
  Future<UserModel?> getUser() async {
    final uid = auth.currentUser!.uid;

    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore.collection('users').doc(uid).get();

    return UserModel.fromJson(snapshot.data()!);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.go('/');
  }
}
