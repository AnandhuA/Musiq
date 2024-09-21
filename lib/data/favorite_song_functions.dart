import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musiq/models/song_model.dart';

class FavoriteSongRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<String> addFavorite({required SongModel song}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        Map<String, dynamic> favoriteData = song.toJson();
        await favoriteCollection.add(favoriteData);
        return "true";
      } else {
        return "not login";
      }
    } catch (e) {
      print('Error adding favorite: $e');
      return "false";
    }
  }

  static Future<bool> removeFavorite({required String songID}) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');
        QuerySnapshot querySnapshot =
            await favoriteCollection.where('id', isEqualTo: songID).get();
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        return true;
      }
      return false;
    } catch (e) {
      print('Error removing favorite: $e');
      return false;
    }
  }

  static Future<List<SongModel>> fetchFavorites() async {
    List<SongModel> favoriteSongs = [];
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;

        CollectionReference favoriteCollection =
            firestore.collection('users').doc(userId).collection('favorite');

        QuerySnapshot querySnapshot = await favoriteCollection.get();
        for (var doc in querySnapshot.docs) {
          favoriteSongs
              .add(SongModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
    return favoriteSongs;
  }

  static Future<void> addSong(SongModel song) async {
    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        CollectionReference musicCollection =
            firestore.collection('users').doc(userId).collection('Last Played');

        final existingSongSnapshot =
            await musicCollection.where('id', isEqualTo: song.id).get();
        if (existingSongSnapshot.docs.isNotEmpty) {
          for (var doc in existingSongSnapshot.docs) {
            await doc.reference.delete();
            log("Existing song removed: ${song.title}");
          }
        }

        Map<String, dynamic> songData = song.toJson();
        songData['addedAt'] = DateTime.now();
        await musicCollection.add(songData);

        log("Song added: ${song.title}");

        final snapshot = await musicCollection.get();
        if (snapshot.docs.length > 15) {
          await musicCollection
              .orderBy('addedAt', descending: false)
              .limit(1)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              doc.reference.delete();
            }
          });
        }
      } else {
        log("Not logged in");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  static Future<List<SongModel>> fetchLastPlayed() async {
    List<SongModel> lastPlayedSongs = [];

    try {
      if (_auth.currentUser?.email != null) {
        final userId = _auth.currentUser!.email;
        CollectionReference musicCollection =
            firestore.collection('users').doc(userId).collection('Last Played');
        final snapshot =
            await musicCollection.orderBy('addedAt', descending: true).get();

        for (var doc in snapshot.docs) {
          lastPlayedSongs
            ..add(SongModel.fromJson(doc.data() as Map<dynamic, dynamic>));
        }
      } else {
        log("Not logged in");
      }
    } catch (e) {
      log("Error fetching last played songs: $e");
    }

    return lastPlayedSongs;
  }
}
