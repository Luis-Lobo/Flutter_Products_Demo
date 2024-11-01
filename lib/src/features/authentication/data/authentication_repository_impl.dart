import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository.dart';
import 'package:flutter_products_demo/src/features/authentication/domain/model/user_model.dart';
import 'package:go_router/go_router.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl();

  @override
  Future<UserModel?> getUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final uid = auth.currentUser!.uid;

    DocumentSnapshot<Map<String, dynamic>> snapshot = 
      await firestore.collection('users').doc(uid).get();

    return UserModel.fromJson(snapshot.data()!);
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.go('/');
  }
}
