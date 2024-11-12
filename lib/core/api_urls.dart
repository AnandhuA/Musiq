class ApiUrls {
  static const String homeData = "https://jiosaavn-api-rs.vercel.app/modules";

  //--------- by id-----------------
  static const String album = "https://jiosaavn-api-rs.vercel.app/album?id=";
  static const String playlist = "https://saavn.dev/api/playlists?id=";
  static const String artist = "https://saavn.dev/api/artists?id=";
  static const String song = "https://saavn.dev/api/songs?ids=";

  //------by search query-------
  static const String globalSearch = "https://saavn.dev/api/search?query=";
  static const String searchSong = "https://saavn.dev/api/search/songs?query=";
  static const String searchAlbums =
      "https://saavn.dev/api/search/albums?query=";
  static const String searchArtists =
      "https://saavn.dev/api/search/artists?query=";
  static const String searchPlayList =
      "https://saavn.dev/api/search/playlists?query=";
}
