import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class StorageService {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<void> saveData(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await database.collection(collection).doc(documentId).set(data);
  }

  Future<DocumentSnapshot> readData(
    String collection,
    String documentId,
  ) async {
    return await database.collection(collection).doc(documentId).get();
  }

  Future<void> deleteData(String collection, String documentId) async {
    await database.collection(collection).doc(documentId).delete();
  }

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}
