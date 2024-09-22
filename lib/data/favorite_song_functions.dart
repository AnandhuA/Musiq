
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
        favoriteData['addedAt'] =
            DateTime.now().toIso8601String(); 

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

  
}
