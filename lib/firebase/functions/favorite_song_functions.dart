import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musiq/models/song.dart';

class FavoriteSongRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<bool> addFavorite({required Song song}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        Map<String, dynamic> favoriteData = song.toJson();
        DocumentReference docRef = await favoriteCollection.add(favoriteData);

        DocumentSnapshot docSnapshot = await docRef.get();
        log('Favorite added successfully: ${docSnapshot.data()}');
        return true;
      }
      return false;
    } catch (e) {
      print('Error adding favorite: $e');
      return false;
    }
  }

  static Future<bool> removeFavorite({required String songID}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        // Query to find the document with the specific songID
        QuerySnapshot querySnapshot =
            await favoriteCollection.where('id', isEqualTo: songID).get();

        // Delete all documents that match the query
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        log('Favorite removed successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('Error removing favorite: $e');
      return false;
    }
  }

  static Future<List<Song>> fetchFavorites() async {
    List<Song> favoriteSongs = [];
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        QuerySnapshot querySnapshot = await favoriteCollection.get();
        for (var doc in querySnapshot.docs) {
          favoriteSongs.add(Song.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
    return favoriteSongs;
  }
}
