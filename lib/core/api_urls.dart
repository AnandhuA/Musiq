class ApiUrls {
  static const String homeData = "https://jiosaavn-api-ts.vercel.app/modules";

  //--------- by id-----------------
  static String album(String albumId) =>
      "https://jiosaavn-api-rs.vercel.app/album?id=$albumId";
  static String playlist(String playListId) =>
      "https://saavn.dev/api/playlists?id=$playListId";
  static String artist(String artistId) =>
      "https://saavn.dev/api/artists?id=$artistId";
  static const String song = "https://saavn.dev/api/songs?ids=";

  //------by search query-------
  static String globalSearch(String query) =>
      "https://saavn.dev/api/search?query=$query";
  static String searchSong(String query) =>
      "https://saavn.dev/api/search/songs?query=$query";
  static String searchAlbums(String query) =>
      "https://saavn.dev/api/search/albums?query=$query";
  static String searchArtists(String query) =>
      "https://saavn.dev/api/search/artists?query=$query";
  static String searchPlayList(String query) =>
      "https://saavn.dev/api/search/playlists?query=$query";
}
