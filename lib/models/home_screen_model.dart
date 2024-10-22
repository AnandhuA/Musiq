class HomeScreenModel {
  HomeScreenModel({
    required this.history,
    required this.newTrending,
    required this.topPlaylists,
    required this.newAlbums,
    required this.browseDiscover,
    required this.globalConfig,
    required this.charts,
    required this.radio,
    required this.artistRecos,
    required this.tagMixes,
    required this.promoVxData19,
    required this.promoVxData68,
    required this.promoVxData76,
    required this.promoVxData185,
    required this.promoVxData69,
    required this.promoVxData90,
    required this.promoVxData107,
    required this.promoVxData118,
    required this.promoVxData176,
    required this.promoVxData113,
    required this.promoVxData114,
    required this.promoVxData116,
    required this.promoVxData140,
    required this.promoVxData211,
    required this.promoVxData122,
    required this.promoVxData184,
    required this.promoVxData207,
    required this.promoVxData117,
    required this.promoVxData139,
    required this.promoVxData164,
    required this.modules,
  });

  final List<dynamic> history;
  final List<NewTrending> newTrending;
  final List<TopPlaylist> topPlaylists;
  final List<NewAlbum> newAlbums;
  final List<BrowseDiscover> browseDiscover;
  final GlobalConfig? globalConfig;
  final List<Chart> charts;
  final List<Radio> radio;
  final List<ArtistReco> artistRecos;
  final List<TagMix> tagMixes;
  final List<PromoVxData164Element> promoVxData19;
  final List<PromoVxData176Element> promoVxData68;
  final List<PromoVxData176Element> promoVxData76;
  final List<PromoVxData176Element> promoVxData185;
  final List<PromoVxData176Element> promoVxData69;
  final List<PromoVxData176Element> promoVxData90;
  final List<PromoVxData107Element> promoVxData107;
  final List<PromoVxData113Element> promoVxData118;
  final List<PromoVxData176Element> promoVxData176;
  final List<PromoVxData113Element> promoVxData113;
  final List<PromoVxData107Element> promoVxData114;
  final List<PromoVxData113Element> promoVxData116;
  final List<PromoVxData140> promoVxData140;
  final List<PromoVxData107Element> promoVxData211;
  final List<PromoVxData113Element> promoVxData122;
  final List<PromoVxData107Element> promoVxData184;
  final List<PromoVxData207> promoVxData207;
  final List<PromoVxData113Element> promoVxData117;
  final List<PromoVxData107Element> promoVxData139;
  final List<PromoVxData164Element> promoVxData164;
  final Modules? modules;

  HomeScreenModel copyWith({
    List<dynamic>? history,
    List<NewTrending>? newTrending,
    List<TopPlaylist>? topPlaylists,
    List<NewAlbum>? newAlbums,
    List<BrowseDiscover>? browseDiscover,
    GlobalConfig? globalConfig,
    List<Chart>? charts,
    List<Radio>? radio,
    List<ArtistReco>? artistRecos,
    List<TagMix>? tagMixes,
    List<PromoVxData164Element>? promoVxData19,
    List<PromoVxData176Element>? promoVxData68,
    List<PromoVxData176Element>? promoVxData76,
    List<PromoVxData176Element>? promoVxData185,
    List<PromoVxData176Element>? promoVxData69,
    List<PromoVxData176Element>? promoVxData90,
    List<PromoVxData107Element>? promoVxData107,
    List<PromoVxData113Element>? promoVxData118,
    List<PromoVxData176Element>? promoVxData176,
    List<PromoVxData113Element>? promoVxData113,
    List<PromoVxData107Element>? promoVxData114,
    List<PromoVxData113Element>? promoVxData116,
    List<PromoVxData140>? promoVxData140,
    List<PromoVxData107Element>? promoVxData211,
    List<PromoVxData113Element>? promoVxData122,
    List<PromoVxData107Element>? promoVxData184,
    List<PromoVxData207>? promoVxData207,
    List<PromoVxData113Element>? promoVxData117,
    List<PromoVxData107Element>? promoVxData139,
    List<PromoVxData164Element>? promoVxData164,
    Modules? modules,
  }) {
    return HomeScreenModel(
      history: history ?? this.history,
      newTrending: newTrending ?? this.newTrending,
      topPlaylists: topPlaylists ?? this.topPlaylists,
      newAlbums: newAlbums ?? this.newAlbums,
      browseDiscover: browseDiscover ?? this.browseDiscover,
      globalConfig: globalConfig ?? this.globalConfig,
      charts: charts ?? this.charts,
      radio: radio ?? this.radio,
      artistRecos: artistRecos ?? this.artistRecos,
      tagMixes: tagMixes ?? this.tagMixes,
      promoVxData19: promoVxData19 ?? this.promoVxData19,
      promoVxData68: promoVxData68 ?? this.promoVxData68,
      promoVxData76: promoVxData76 ?? this.promoVxData76,
      promoVxData185: promoVxData185 ?? this.promoVxData185,
      promoVxData69: promoVxData69 ?? this.promoVxData69,
      promoVxData90: promoVxData90 ?? this.promoVxData90,
      promoVxData107: promoVxData107 ?? this.promoVxData107,
      promoVxData118: promoVxData118 ?? this.promoVxData118,
      promoVxData176: promoVxData176 ?? this.promoVxData176,
      promoVxData113: promoVxData113 ?? this.promoVxData113,
      promoVxData114: promoVxData114 ?? this.promoVxData114,
      promoVxData116: promoVxData116 ?? this.promoVxData116,
      promoVxData140: promoVxData140 ?? this.promoVxData140,
      promoVxData211: promoVxData211 ?? this.promoVxData211,
      promoVxData122: promoVxData122 ?? this.promoVxData122,
      promoVxData184: promoVxData184 ?? this.promoVxData184,
      promoVxData207: promoVxData207 ?? this.promoVxData207,
      promoVxData117: promoVxData117 ?? this.promoVxData117,
      promoVxData139: promoVxData139 ?? this.promoVxData139,
      promoVxData164: promoVxData164 ?? this.promoVxData164,
      modules: modules ?? this.modules,
    );
  }

  factory HomeScreenModel.fromJson(Map<dynamic, dynamic> json) {
    return HomeScreenModel(
      history: json["history"] == null
          ? []
          : List<dynamic>.from(json["history"]!.map((x) => x)),
      newTrending: json["new_trending"] == null
          ? []
          : List<NewTrending>.from(
              json["new_trending"]!.map((x) => NewTrending.fromJson(x))),
      topPlaylists: json["top_playlists"] == null
          ? []
          : List<TopPlaylist>.from(
              json["top_playlists"]!.map((x) => TopPlaylist.fromJson(x))),
      newAlbums: json["new_albums"] == null
          ? []
          : List<NewAlbum>.from(
              json["new_albums"]!.map((x) => NewAlbum.fromJson(x))),
      browseDiscover: json["browse_discover"] == null
          ? []
          : List<BrowseDiscover>.from(
              json["browse_discover"]!.map((x) => BrowseDiscover.fromJson(x))),
      globalConfig: json["global_config"] == null
          ? null
          : GlobalConfig.fromJson(json["global_config"]),
      charts: json["charts"] == null
          ? []
          : List<Chart>.from(json["charts"]!.map((x) => Chart.fromJson(x))),
      radio: json["radio"] == null
          ? []
          : List<Radio>.from(json["radio"]!.map((x) => Radio.fromJson(x))),
      artistRecos: json["artist_recos"] == null
          ? []
          : List<ArtistReco>.from(
              json["artist_recos"]!.map((x) => ArtistReco.fromJson(x))),
      tagMixes: json["tag_mixes"] == null
          ? []
          : List<TagMix>.from(
              json["tag_mixes"]!.map((x) => TagMix.fromJson(x))),
      promoVxData19: json["promo:vx:data:19"] == null
          ? []
          : List<PromoVxData164Element>.from(json["promo:vx:data:19"]!
              .map((x) => PromoVxData164Element.fromJson(x))),
      promoVxData68: json["promo:vx:data:68"] == null
          ? []
          : List<PromoVxData176Element>.from(json["promo:vx:data:68"]!
              .map((x) => PromoVxData176Element.fromJson(x))),
      promoVxData76: json["promo:vx:data:76"] == null
          ? []
          : List<PromoVxData176Element>.from(json["promo:vx:data:76"]!
              .map((x) => PromoVxData176Element.fromJson(x))),
      promoVxData185: json["promo:vx:data:185"] == null
          ? []
          : List<PromoVxData176Element>.from(json["promo:vx:data:185"]!
              .map((x) => PromoVxData176Element.fromJson(x))),
      promoVxData69: json["promo:vx:data:69"] == null
          ? []
          : List<PromoVxData176Element>.from(json["promo:vx:data:69"]!
              .map((x) => PromoVxData176Element.fromJson(x))),
      promoVxData90: json["promo:vx:data:90"] == null
          ? []
          : List<PromoVxData176Element>.from(json["promo:vx:data:90"]!
              .map((x) => PromoVxData176Element.fromJson(x))),
      promoVxData107: json["promo:vx:data:107"] == null
          ? []
          : List<PromoVxData107Element>.from(json["promo:vx:data:107"]!
              .map((x) => PromoVxData107Element.fromJson(x))),
      promoVxData118: json["promo:vx:data:118"] == null
          ? []
          : List<PromoVxData113Element>.from(json["promo:vx:data:118"]!
              .map((x) => PromoVxData113Element.fromJson(x))),
      promoVxData176: json["promo:vx:data:176"] == null
          ? []
          : List<PromoVxData176Element>.from(json["promo:vx:data:176"]!
              .map((x) => PromoVxData176Element.fromJson(x))),
      promoVxData113: json["promo:vx:data:113"] == null
          ? []
          : List<PromoVxData113Element>.from(json["promo:vx:data:113"]!
              .map((x) => PromoVxData113Element.fromJson(x))),
      promoVxData114: json["promo:vx:data:114"] == null
          ? []
          : List<PromoVxData107Element>.from(json["promo:vx:data:114"]!
              .map((x) => PromoVxData107Element.fromJson(x))),
      promoVxData116: json["promo:vx:data:116"] == null
          ? []
          : List<PromoVxData113Element>.from(json["promo:vx:data:116"]!
              .map((x) => PromoVxData113Element.fromJson(x))),
      promoVxData140: json["promo:vx:data:140"] == null
          ? []
          : List<PromoVxData140>.from(json["promo:vx:data:140"]!
              .map((x) => PromoVxData140.fromJson(x))),
      promoVxData211: json["promo:vx:data:211"] == null
          ? []
          : List<PromoVxData107Element>.from(json["promo:vx:data:211"]!
              .map((x) => PromoVxData107Element.fromJson(x))),
      promoVxData122: json["promo:vx:data:122"] == null
          ? []
          : List<PromoVxData113Element>.from(json["promo:vx:data:122"]!
              .map((x) => PromoVxData113Element.fromJson(x))),
      promoVxData184: json["promo:vx:data:184"] == null
          ? []
          : List<PromoVxData107Element>.from(json["promo:vx:data:184"]!
              .map((x) => PromoVxData107Element.fromJson(x))),
      promoVxData207: json["promo:vx:data:207"] == null
          ? []
          : List<PromoVxData207>.from(json["promo:vx:data:207"]!
              .map((x) => PromoVxData207.fromJson(x))),
      promoVxData117: json["promo:vx:data:117"] == null
          ? []
          : List<PromoVxData113Element>.from(json["promo:vx:data:117"]!
              .map((x) => PromoVxData113Element.fromJson(x))),
      promoVxData139: json["promo:vx:data:139"] == null
          ? []
          : List<PromoVxData107Element>.from(json["promo:vx:data:139"]!
              .map((x) => PromoVxData107Element.fromJson(x))),
      promoVxData164: json["promo:vx:data:164"] == null
          ? []
          : List<PromoVxData164Element>.from(json["promo:vx:data:164"]!
              .map((x) => PromoVxData164Element.fromJson(x))),
      modules:
          json["modules"] == null ? null : Modules.fromJson(json["modules"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "history": history.map((x) => x).toList(),
        "new_trending": newTrending.map((x) => x.toJson()).toList(),
        "top_playlists": topPlaylists.map((x) => x.toJson()).toList(),
        "new_albums": newAlbums.map((x) => x.toJson()).toList(),
        "browse_discover": browseDiscover.map((x) => x.toJson()).toList(),
        "global_config": globalConfig?.toJson(),
        "charts": charts.map((x) => x.toJson()).toList(),
        "radio": radio.map((x) => x.toJson()).toList(),
        "artist_recos": artistRecos.map((x) => x.toJson()).toList(),
        "tag_mixes": tagMixes.map((x) => x.toJson()).toList(),
        "promo:vx:data:19": promoVxData19.map((x) => x.toJson()).toList(),
        "promo:vx:data:68": promoVxData68.map((x) => x.toJson()).toList(),
        "promo:vx:data:76": promoVxData76.map((x) => x.toJson()).toList(),
        "promo:vx:data:185": promoVxData185.map((x) => x.toJson()).toList(),
        "promo:vx:data:69": promoVxData69.map((x) => x.toJson()).toList(),
        "promo:vx:data:90": promoVxData90.map((x) => x.toJson()).toList(),
        "promo:vx:data:107": promoVxData107.map((x) => x.toJson()).toList(),
        "promo:vx:data:118": promoVxData118.map((x) => x.toJson()).toList(),
        "promo:vx:data:176": promoVxData176.map((x) => x.toJson()).toList(),
        "promo:vx:data:113": promoVxData113.map((x) => x.toJson()).toList(),
        "promo:vx:data:114": promoVxData114.map((x) => x.toJson()).toList(),
        "promo:vx:data:116": promoVxData116.map((x) => x.toJson()).toList(),
        "promo:vx:data:140": promoVxData140.map((x) => x.toJson()).toList(),
        "promo:vx:data:211": promoVxData211.map((x) => x.toJson()).toList(),
        "promo:vx:data:122": promoVxData122.map((x) => x.toJson()).toList(),
        "promo:vx:data:184": promoVxData184.map((x) => x.toJson()).toList(),
        "promo:vx:data:207": promoVxData207.map((x) => x.toJson()).toList(),
        "promo:vx:data:117": promoVxData117.map((x) => x.toJson()).toList(),
        "promo:vx:data:139": promoVxData139.map((x) => x.toJson()).toList(),
        "promo:vx:data:164": promoVxData164.map((x) => x.toJson()).toList(),
        "modules": modules?.toJson(),
      };

  @override
  String toString() {
    return "$history, $newTrending, $topPlaylists, $newAlbums, $browseDiscover, $globalConfig, $charts, $radio, $artistRecos, $tagMixes, $promoVxData19, $promoVxData68, $promoVxData76, $promoVxData185, $promoVxData69, $promoVxData90, $promoVxData107, $promoVxData118, $promoVxData176, $promoVxData113, $promoVxData114, $promoVxData116, $promoVxData140, $promoVxData211, $promoVxData122, $promoVxData184, $promoVxData207, $promoVxData117, $promoVxData139, $promoVxData164, $modules, ";
  }
}

class ArtistReco {
  ArtistReco({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final ArtistRecoMoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;

  ArtistReco copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    ArtistRecoMoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
  }) {
    return ArtistReco(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
    );
  }

  factory ArtistReco.fromJson(Map<String, dynamic> json) {
    return ArtistReco(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : ArtistRecoMoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, ";
  }
}

class ArtistRecoMoreInfo {
  ArtistRecoMoreInfo({
    required this.featuredStationType,
    required this.query,
    required this.stationDisplayText,
  });

  final String? featuredStationType;
  final String? query;
  final String? stationDisplayText;

  ArtistRecoMoreInfo copyWith({
    String? featuredStationType,
    String? query,
    String? stationDisplayText,
  }) {
    return ArtistRecoMoreInfo(
      featuredStationType: featuredStationType ?? this.featuredStationType,
      query: query ?? this.query,
      stationDisplayText: stationDisplayText ?? this.stationDisplayText,
    );
  }

  factory ArtistRecoMoreInfo.fromJson(Map<String, dynamic> json) {
    return ArtistRecoMoreInfo(
      featuredStationType: json["featured_station_type"],
      query: json["query"],
      stationDisplayText: json["station_display_text"],
    );
  }

  Map<String, dynamic> toJson() => {
        "featured_station_type": featuredStationType,
        "query": query,
        "station_display_text": stationDisplayText,
      };

  @override
  String toString() {
    return "$featuredStationType, $query, $stationDisplayText, ";
  }
}

class BrowseDiscover {
  BrowseDiscover({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final BrowseDiscoverMoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;

  BrowseDiscover copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    BrowseDiscoverMoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
  }) {
    return BrowseDiscover(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
    );
  }

  factory BrowseDiscover.fromJson(Map<String, dynamic> json) {
    return BrowseDiscover(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : BrowseDiscoverMoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, ";
  }
}

class BrowseDiscoverMoreInfo {
  BrowseDiscoverMoreInfo({
    required this.badge,
    required this.subType,
    required this.available,
    required this.isFeatured,
    required this.tags,
    required this.videoUrl,
    required this.videoThumbnail,
  });

  final String? badge;
  final String? subType;
  final String? available;
  final String? isFeatured;
  final dynamic tags;
  final String? videoUrl;
  final String? videoThumbnail;

  BrowseDiscoverMoreInfo copyWith({
    String? badge,
    String? subType,
    String? available,
    String? isFeatured,
    dynamic tags,
    String? videoUrl,
    String? videoThumbnail,
  }) {
    return BrowseDiscoverMoreInfo(
      badge: badge ?? this.badge,
      subType: subType ?? this.subType,
      available: available ?? this.available,
      isFeatured: isFeatured ?? this.isFeatured,
      tags: tags ?? this.tags,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
    );
  }

  factory BrowseDiscoverMoreInfo.fromJson(Map<String, dynamic> json) {
    return BrowseDiscoverMoreInfo(
      badge: json["badge"],
      subType: json["sub_type"],
      available: json["available"],
      isFeatured: json["is_featured"],
      tags: json["tags"],
      videoUrl: json["video_url"],
      videoThumbnail: json["video_thumbnail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "badge": badge,
        "sub_type": subType,
        "available": available,
        "is_featured": isFeatured,
        "tags": tags,
        "video_url": videoUrl,
        "video_thumbnail": videoThumbnail,
      };

  @override
  String toString() {
    return "$badge, $subType, $available, $isFeatured, $tags, $videoUrl, $videoThumbnail, ";
  }
}

class TagsClass {
  TagsClass({
    required this.mood,
    required this.situation,
    required this.seasonality,
    required this.genre,
  });

  final List<String> mood;
  final List<String> situation;
  final List<String> seasonality;
  final List<String> genre;

  TagsClass copyWith({
    List<String>? mood,
    List<String>? situation,
    List<String>? seasonality,
    List<String>? genre,
  }) {
    return TagsClass(
      mood: mood ?? this.mood,
      situation: situation ?? this.situation,
      seasonality: seasonality ?? this.seasonality,
      genre: genre ?? this.genre,
    );
  }

  factory TagsClass.fromJson(Map<String, dynamic> json) {
    return TagsClass(
      mood: json["mood"] == null
          ? []
          : List<String>.from(json["mood"]!.map((x) => x)),
      situation: json["situation"] == null
          ? []
          : List<String>.from(json["situation"]!.map((x) => x)),
      seasonality: json["seasonality"] == null
          ? []
          : List<String>.from(json["seasonality"]!.map((x) => x)),
      genre: json["genre"] == null
          ? []
          : List<String>.from(json["genre"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "mood": mood.map((x) => x).toList(),
        "situation": situation.map((x) => x).toList(),
        "seasonality": seasonality.map((x) => x).toList(),
        "genre": genre.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$mood, $situation, $seasonality, $genre, ";
  }
}

class Chart {
  Chart({
    required this.id,
    required this.image,
    required this.title,
    required this.type,
    required this.count,
    required this.permaUrl,
    required this.moreInfo,
    required this.subtitle,
    required this.explicitContent,
    required this.miniObj,
    required this.language,
  });

  final String? id;
  final String? image;
  final String? title;
  final String? type;
  final num? count;
  final String? permaUrl;
  final ChartMoreInfo? moreInfo;
  final String? subtitle;
  final String? explicitContent;
  final bool? miniObj;
  final String? language;

  Chart copyWith({
    String? id,
    String? image,
    String? title,
    String? type,
    num? count,
    String? permaUrl,
    ChartMoreInfo? moreInfo,
    String? subtitle,
    String? explicitContent,
    bool? miniObj,
    String? language,
  }) {
    return Chart(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      type: type ?? this.type,
      count: count ?? this.count,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      subtitle: subtitle ?? this.subtitle,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
      language: language ?? this.language,
    );
  }

  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      id: json["id"],
      image: json["image"],
      title: json["title"],
      type: json["type"],
      count: json["count"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : ChartMoreInfo.fromJson(json["more_info"]),
      subtitle: json["subtitle"],
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
      language: json["language"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "type": type,
        "count": count,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "subtitle": subtitle,
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
        "language": language,
      };

  @override
  String toString() {
    return "$id, $image, $title, $type, $count, $permaUrl, $moreInfo, $subtitle, $explicitContent, $miniObj, $language, ";
  }
}

class ChartMoreInfo {
  ChartMoreInfo({
    required this.firstname,
  });

  final String? firstname;

  ChartMoreInfo copyWith({
    String? firstname,
  }) {
    return ChartMoreInfo(
      firstname: firstname ?? this.firstname,
    );
  }

  factory ChartMoreInfo.fromJson(Map<String, dynamic> json) {
    return ChartMoreInfo(
      firstname: json["firstname"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
      };

  @override
  String toString() {
    return "$firstname, ";
  }
}

class GlobalConfig {
  GlobalConfig({
    required this.weeklyTopSongsListid,
    required this.randomSongsListid,
    required this.phnOtpProviders,
  });

  final SongsListid? weeklyTopSongsListid;
  final SongsListid? randomSongsListid;
  final PhnOtpProviders? phnOtpProviders;

  GlobalConfig copyWith({
    SongsListid? weeklyTopSongsListid,
    SongsListid? randomSongsListid,
    PhnOtpProviders? phnOtpProviders,
  }) {
    return GlobalConfig(
      weeklyTopSongsListid: weeklyTopSongsListid ?? this.weeklyTopSongsListid,
      randomSongsListid: randomSongsListid ?? this.randomSongsListid,
      phnOtpProviders: phnOtpProviders ?? this.phnOtpProviders,
    );
  }

  factory GlobalConfig.fromJson(Map<String, dynamic> json) {
    return GlobalConfig(
      weeklyTopSongsListid: json["weekly_top_songs_listid"] == null
          ? null
          : SongsListid.fromJson(json["weekly_top_songs_listid"]),
      randomSongsListid: json["random_songs_listid"] == null
          ? null
          : SongsListid.fromJson(json["random_songs_listid"]),
      phnOtpProviders: json["phn_otp_providers"] == null
          ? null
          : PhnOtpProviders.fromJson(json["phn_otp_providers"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "weekly_top_songs_listid": weeklyTopSongsListid?.toJson(),
        "random_songs_listid": randomSongsListid?.toJson(),
        "phn_otp_providers": phnOtpProviders?.toJson(),
      };

  @override
  String toString() {
    return "$weeklyTopSongsListid, $randomSongsListid, $phnOtpProviders, ";
  }
}

class PhnOtpProviders {
  PhnOtpProviders({
    required this.the91,
  });

  final String? the91;

  PhnOtpProviders copyWith({
    String? the91,
  }) {
    return PhnOtpProviders(
      the91: the91 ?? this.the91,
    );
  }

  factory PhnOtpProviders.fromJson(Map<String, dynamic> json) {
    return PhnOtpProviders(
      the91: json["+91"],
    );
  }

  Map<String, dynamic> toJson() => {
        "+91": the91,
      };

  @override
  String toString() {
    return "$the91, ";
  }
}

class SongsListid {
  SongsListid({
    required this.english,
    required this.hindi,
    required this.malayalam,
    required this.tamil,
  });

  final English? english;
  final English? hindi;
  final English? malayalam;
  final English? tamil;

  SongsListid copyWith({
    English? english,
    English? hindi,
    English? malayalam,
    English? tamil,
  }) {
    return SongsListid(
      english: english ?? this.english,
      hindi: hindi ?? this.hindi,
      malayalam: malayalam ?? this.malayalam,
      tamil: tamil ?? this.tamil,
    );
  }

  factory SongsListid.fromJson(Map<String, dynamic> json) {
    return SongsListid(
      english:
          json["english"] == null ? null : English.fromJson(json["english"]),
      hindi: json["hindi"] == null ? null : English.fromJson(json["hindi"]),
      malayalam: json["malayalam"] == null
          ? null
          : English.fromJson(json["malayalam"]),
      tamil: json["tamil"] == null ? null : English.fromJson(json["tamil"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "english": english?.toJson(),
        "hindi": hindi?.toJson(),
        "malayalam": malayalam?.toJson(),
        "tamil": tamil?.toJson(),
      };

  @override
  String toString() {
    return "$english, $hindi, $malayalam, $tamil, ";
  }
}

class English {
  English({
    required this.listid,
    required this.image,
    required this.count,
    required this.title,
  });

  final String? listid;
  final String? image;
  final num? count;
  final String? title;

  English copyWith({
    String? listid,
    String? image,
    num? count,
    String? title,
  }) {
    return English(
      listid: listid ?? this.listid,
      image: image ?? this.image,
      count: count ?? this.count,
      title: title ?? this.title,
    );
  }

  factory English.fromJson(Map<String, dynamic> json) {
    return English(
      listid: json["listid"],
      image: json["image"],
      count: json["count"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "listid": listid,
        "image": image,
        "count": count,
        "title": title,
      };

  @override
  String toString() {
    return "$listid, $image, $count, $title, ";
  }
}

class Modules {
  Modules({
    required this.newTrending,
    required this.charts,
    required this.newAlbums,
    required this.topPlaylists,
    required this.promoVxData107,
    required this.radio,
    required this.artistRecos,
    required this.promoVxData19,
    required this.promoVxData68,
    required this.promoVxData76,
    required this.tagMixes,
    required this.promoVxData185,
    required this.promoVxData69,
    required this.promoVxData90,
    required this.promoVxData118,
    required this.promoVxData176,
    required this.promoVxData113,
    required this.promoVxData114,
    required this.promoVxData116,
    required this.promoVxData140,
    required this.promoVxData211,
    required this.promoVxData122,
    required this.promoVxData184,
    required this.promoVxData207,
    required this.promoVxData117,
    required this.promoVxData139,
    required this.promoVxData164,
  });

  final Charts? newTrending;
  final Charts? charts;
  final Charts? newAlbums;
  final Charts? topPlaylists;
  final ArtistRecos? promoVxData107;
  final Charts? radio;
  final ArtistRecos? artistRecos;
  final ArtistRecos? promoVxData19;
  final ArtistRecos? promoVxData68;
  final ArtistRecos? promoVxData76;
  final ArtistRecos? tagMixes;
  final ArtistRecos? promoVxData185;
  final ArtistRecos? promoVxData69;
  final ArtistRecos? promoVxData90;
  final ArtistRecos? promoVxData118;
  final ArtistRecos? promoVxData176;
  final ArtistRecos? promoVxData113;
  final ArtistRecos? promoVxData114;
  final ArtistRecos? promoVxData116;
  final ArtistRecos? promoVxData140;
  final ArtistRecos? promoVxData211;
  final ArtistRecos? promoVxData122;
  final ArtistRecos? promoVxData184;
  final ArtistRecos? promoVxData207;
  final ArtistRecos? promoVxData117;
  final ArtistRecos? promoVxData139;
  final ArtistRecos? promoVxData164;

  Modules copyWith({
    Charts? newTrending,
    Charts? charts,
    Charts? newAlbums,
    Charts? topPlaylists,
    ArtistRecos? promoVxData107,
    Charts? radio,
    ArtistRecos? artistRecos,
    ArtistRecos? promoVxData19,
    ArtistRecos? promoVxData68,
    ArtistRecos? promoVxData76,
    ArtistRecos? tagMixes,
    ArtistRecos? promoVxData185,
    ArtistRecos? promoVxData69,
    ArtistRecos? promoVxData90,
    ArtistRecos? promoVxData118,
    ArtistRecos? promoVxData176,
    ArtistRecos? promoVxData113,
    ArtistRecos? promoVxData114,
    ArtistRecos? promoVxData116,
    ArtistRecos? promoVxData140,
    ArtistRecos? promoVxData211,
    ArtistRecos? promoVxData122,
    ArtistRecos? promoVxData184,
    ArtistRecos? promoVxData207,
    ArtistRecos? promoVxData117,
    ArtistRecos? promoVxData139,
    ArtistRecos? promoVxData164,
  }) {
    return Modules(
      newTrending: newTrending ?? this.newTrending,
      charts: charts ?? this.charts,
      newAlbums: newAlbums ?? this.newAlbums,
      topPlaylists: topPlaylists ?? this.topPlaylists,
      promoVxData107: promoVxData107 ?? this.promoVxData107,
      radio: radio ?? this.radio,
      artistRecos: artistRecos ?? this.artistRecos,
      promoVxData19: promoVxData19 ?? this.promoVxData19,
      promoVxData68: promoVxData68 ?? this.promoVxData68,
      promoVxData76: promoVxData76 ?? this.promoVxData76,
      tagMixes: tagMixes ?? this.tagMixes,
      promoVxData185: promoVxData185 ?? this.promoVxData185,
      promoVxData69: promoVxData69 ?? this.promoVxData69,
      promoVxData90: promoVxData90 ?? this.promoVxData90,
      promoVxData118: promoVxData118 ?? this.promoVxData118,
      promoVxData176: promoVxData176 ?? this.promoVxData176,
      promoVxData113: promoVxData113 ?? this.promoVxData113,
      promoVxData114: promoVxData114 ?? this.promoVxData114,
      promoVxData116: promoVxData116 ?? this.promoVxData116,
      promoVxData140: promoVxData140 ?? this.promoVxData140,
      promoVxData211: promoVxData211 ?? this.promoVxData211,
      promoVxData122: promoVxData122 ?? this.promoVxData122,
      promoVxData184: promoVxData184 ?? this.promoVxData184,
      promoVxData207: promoVxData207 ?? this.promoVxData207,
      promoVxData117: promoVxData117 ?? this.promoVxData117,
      promoVxData139: promoVxData139 ?? this.promoVxData139,
      promoVxData164: promoVxData164 ?? this.promoVxData164,
    );
  }

  factory Modules.fromJson(Map<String, dynamic> json) {
    return Modules(
      newTrending: json["new_trending"] == null
          ? null
          : Charts.fromJson(json["new_trending"]),
      charts: json["charts"] == null ? null : Charts.fromJson(json["charts"]),
      newAlbums: json["new_albums"] == null
          ? null
          : Charts.fromJson(json["new_albums"]),
      topPlaylists: json["top_playlists"] == null
          ? null
          : Charts.fromJson(json["top_playlists"]),
      promoVxData107: json["promo:vx:data:107"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:107"]),
      radio: json["radio"] == null ? null : Charts.fromJson(json["radio"]),
      artistRecos: json["artist_recos"] == null
          ? null
          : ArtistRecos.fromJson(json["artist_recos"]),
      promoVxData19: json["promo:vx:data:19"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:19"]),
      promoVxData68: json["promo:vx:data:68"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:68"]),
      promoVxData76: json["promo:vx:data:76"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:76"]),
      tagMixes: json["tag_mixes"] == null
          ? null
          : ArtistRecos.fromJson(json["tag_mixes"]),
      promoVxData185: json["promo:vx:data:185"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:185"]),
      promoVxData69: json["promo:vx:data:69"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:69"]),
      promoVxData90: json["promo:vx:data:90"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:90"]),
      promoVxData118: json["promo:vx:data:118"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:118"]),
      promoVxData176: json["promo:vx:data:176"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:176"]),
      promoVxData113: json["promo:vx:data:113"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:113"]),
      promoVxData114: json["promo:vx:data:114"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:114"]),
      promoVxData116: json["promo:vx:data:116"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:116"]),
      promoVxData140: json["promo:vx:data:140"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:140"]),
      promoVxData211: json["promo:vx:data:211"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:211"]),
      promoVxData122: json["promo:vx:data:122"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:122"]),
      promoVxData184: json["promo:vx:data:184"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:184"]),
      promoVxData207: json["promo:vx:data:207"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:207"]),
      promoVxData117: json["promo:vx:data:117"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:117"]),
      promoVxData139: json["promo:vx:data:139"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:139"]),
      promoVxData164: json["promo:vx:data:164"] == null
          ? null
          : ArtistRecos.fromJson(json["promo:vx:data:164"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "new_trending": newTrending?.toJson(),
        "charts": charts?.toJson(),
        "new_albums": newAlbums?.toJson(),
        "top_playlists": topPlaylists?.toJson(),
        "promo:vx:data:107": promoVxData107?.toJson(),
        "radio": radio?.toJson(),
        "artist_recos": artistRecos?.toJson(),
        "promo:vx:data:19": promoVxData19?.toJson(),
        "promo:vx:data:68": promoVxData68?.toJson(),
        "promo:vx:data:76": promoVxData76?.toJson(),
        "tag_mixes": tagMixes?.toJson(),
        "promo:vx:data:185": promoVxData185?.toJson(),
        "promo:vx:data:69": promoVxData69?.toJson(),
        "promo:vx:data:90": promoVxData90?.toJson(),
        "promo:vx:data:118": promoVxData118?.toJson(),
        "promo:vx:data:176": promoVxData176?.toJson(),
        "promo:vx:data:113": promoVxData113?.toJson(),
        "promo:vx:data:114": promoVxData114?.toJson(),
        "promo:vx:data:116": promoVxData116?.toJson(),
        "promo:vx:data:140": promoVxData140?.toJson(),
        "promo:vx:data:211": promoVxData211?.toJson(),
        "promo:vx:data:122": promoVxData122?.toJson(),
        "promo:vx:data:184": promoVxData184?.toJson(),
        "promo:vx:data:207": promoVxData207?.toJson(),
        "promo:vx:data:117": promoVxData117?.toJson(),
        "promo:vx:data:139": promoVxData139?.toJson(),
        "promo:vx:data:164": promoVxData164?.toJson(),
      };

  @override
  String toString() {
    return "$newTrending, $charts, $newAlbums, $topPlaylists, $promoVxData107, $radio, $artistRecos, $promoVxData19, $promoVxData68, $promoVxData76, $tagMixes, $promoVxData185, $promoVxData69, $promoVxData90, $promoVxData118, $promoVxData176, $promoVxData113, $promoVxData114, $promoVxData116, $promoVxData140, $promoVxData211, $promoVxData122, $promoVxData184, $promoVxData207, $promoVxData117, $promoVxData139, $promoVxData164, ";
  }
}

class ArtistRecos {
  ArtistRecos({
    required this.source,
    required this.position,
    required this.score,
    required this.bucket,
    required this.scrollType,
    required this.title,
    required this.subtitle,
    required this.highlight,
    required this.simpleHeader,
    required this.noHeader,
    required this.hideMeta,
    required this.viewMore,
    required this.isJtModule,
  });

  final String? source;
  final num? position;
  final String? score;
  final String? bucket;
  final String? scrollType;
  final String? title;
  final String? subtitle;
  final String? highlight;
  final bool? simpleHeader;
  final bool? noHeader;
  final bool? hideMeta;
  final List<dynamic> viewMore;
  final bool? isJtModule;

  ArtistRecos copyWith({
    String? source,
    num? position,
    String? score,
    String? bucket,
    String? scrollType,
    String? title,
    String? subtitle,
    String? highlight,
    bool? simpleHeader,
    bool? noHeader,
    bool? hideMeta,
    List<dynamic>? viewMore,
    bool? isJtModule,
  }) {
    return ArtistRecos(
      source: source ?? this.source,
      position: position ?? this.position,
      score: score ?? this.score,
      bucket: bucket ?? this.bucket,
      scrollType: scrollType ?? this.scrollType,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      highlight: highlight ?? this.highlight,
      simpleHeader: simpleHeader ?? this.simpleHeader,
      noHeader: noHeader ?? this.noHeader,
      hideMeta: hideMeta ?? this.hideMeta,
      viewMore: viewMore ?? this.viewMore,
      isJtModule: isJtModule ?? this.isJtModule,
    );
  }

  factory ArtistRecos.fromJson(Map<String, dynamic> json) {
    return ArtistRecos(
      source: json["source"],
      position: json["position"],
      score: json["score"],
      bucket: json["bucket"],
      scrollType: json["scroll_type"],
      title: json["title"],
      subtitle: json["subtitle"],
      highlight: json["highlight"],
      simpleHeader: json["simpleHeader"],
      noHeader: json["noHeader"],
      hideMeta: json["hideMeta"],
      viewMore: json["view_more"] == null
          ? []
          : List<dynamic>.from(json["view_more"]!.map((x) => x)),
      isJtModule: json["is_JT_module"],
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source,
        "position": position,
        "score": score,
        "bucket": bucket,
        "scroll_type": scrollType,
        "title": title,
        "subtitle": subtitle,
        "highlight": highlight,
        "simpleHeader": simpleHeader,
        "noHeader": noHeader,
        "hideMeta": hideMeta,
        "view_more": viewMore.map((x) => x).toList(),
        "is_JT_module": isJtModule,
      };

  @override
  String toString() {
    return "$source, $position, $score, $bucket, $scrollType, $title, $subtitle, $highlight, $simpleHeader, $noHeader, $hideMeta, $viewMore, $isJtModule, ";
  }
}

class Charts {
  Charts({
    required this.source,
    required this.position,
    required this.score,
    required this.bucket,
    required this.scrollType,
    required this.title,
    required this.subtitle,
    required this.highlight,
    required this.simpleHeader,
    required this.noHeader,
    required this.hideMeta,
    required this.featured,
    required this.featuredText,
    required this.viewMore,
    required this.isJtModule,
  });

  final String? source;
  final num? position;
  final String? score;
  final String? bucket;
  final String? scrollType;
  final String? title;
  final String? subtitle;
  final String? highlight;
  final bool? simpleHeader;
  final bool? noHeader;
  final bool? hideMeta;
  final bool? featured;
  final String? featuredText;
  final ViewMore? viewMore;
  final bool? isJtModule;

  Charts copyWith({
    String? source,
    num? position,
    String? score,
    String? bucket,
    String? scrollType,
    String? title,
    String? subtitle,
    String? highlight,
    bool? simpleHeader,
    bool? noHeader,
    bool? hideMeta,
    bool? featured,
    String? featuredText,
    ViewMore? viewMore,
    bool? isJtModule,
  }) {
    return Charts(
      source: source ?? this.source,
      position: position ?? this.position,
      score: score ?? this.score,
      bucket: bucket ?? this.bucket,
      scrollType: scrollType ?? this.scrollType,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      highlight: highlight ?? this.highlight,
      simpleHeader: simpleHeader ?? this.simpleHeader,
      noHeader: noHeader ?? this.noHeader,
      hideMeta: hideMeta ?? this.hideMeta,
      featured: featured ?? this.featured,
      featuredText: featuredText ?? this.featuredText,
      viewMore: viewMore ?? this.viewMore,
      isJtModule: isJtModule ?? this.isJtModule,
    );
  }

  factory Charts.fromJson(Map<String, dynamic> json) {
    return Charts(
      source: json["source"],
      position: json["position"],
      score: json["score"],
      bucket: json["bucket"],
      scrollType: json["scroll_type"],
      title: json["title"],
      subtitle: json["subtitle"],
      highlight: json["highlight"],
      simpleHeader: json["simpleHeader"],
      noHeader: json["noHeader"],
      hideMeta: json["hideMeta"],
      featured: json["featured"],
      featuredText: json["featured_text"],
      viewMore: json["view_more"] == null
          ? null
          : ViewMore.fromJson(json["view_more"]),
      isJtModule: json["is_JT_module"],
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source,
        "position": position,
        "score": score,
        "bucket": bucket,
        "scroll_type": scrollType,
        "title": title,
        "subtitle": subtitle,
        "highlight": highlight,
        "simpleHeader": simpleHeader,
        "noHeader": noHeader,
        "hideMeta": hideMeta,
        "featured": featured,
        "featured_text": featuredText,
        "view_more": viewMore?.toJson(),
        "is_JT_module": isJtModule,
      };

  @override
  String toString() {
    return "$source, $position, $score, $bucket, $scrollType, $title, $subtitle, $highlight, $simpleHeader, $noHeader, $hideMeta, $featured, $featuredText, $viewMore, $isJtModule, ";
  }
}

class ViewMore {
  ViewMore({
    required this.api,
    required this.pageParam,
    required this.sizeParam,
    required this.defaultSize,
    required this.scrollType,
  });

  final String? api;
  final String? pageParam;
  final String? sizeParam;
  final num? defaultSize;
  final String? scrollType;

  ViewMore copyWith({
    String? api,
    String? pageParam,
    String? sizeParam,
    num? defaultSize,
    String? scrollType,
  }) {
    return ViewMore(
      api: api ?? this.api,
      pageParam: pageParam ?? this.pageParam,
      sizeParam: sizeParam ?? this.sizeParam,
      defaultSize: defaultSize ?? this.defaultSize,
      scrollType: scrollType ?? this.scrollType,
    );
  }

  factory ViewMore.fromJson(Map<String, dynamic> json) {
    return ViewMore(
      api: json["api"],
      pageParam: json["page_param"],
      sizeParam: json["size_param"],
      defaultSize: json["default_size"],
      scrollType: json["scroll_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "api": api,
        "page_param": pageParam,
        "size_param": sizeParam,
        "default_size": defaultSize,
        "scroll_type": scrollType,
      };

  @override
  String toString() {
    return "$api, $pageParam, $sizeParam, $defaultSize, $scrollType, ";
  }
}

class NewAlbum {
  NewAlbum({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.headerDesc,
    required this.type,
    required this.permaUrl,
    required this.image,
    required this.language,
    required this.year,
    required this.playCount,
    required this.explicitContent,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.moreInfo,
    required this.buttonTooltipInfo,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? headerDesc;
  final String? type;
  final String? permaUrl;
  final String? image;
  final String? language;
  final String? year;
  final String? playCount;
  final String? explicitContent;
  final String? listCount;
  final String? listType;
  final String? list;
  final NewAlbumMoreInfo? moreInfo;
  final List<dynamic> buttonTooltipInfo;

  NewAlbum copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? headerDesc,
    String? type,
    String? permaUrl,
    String? image,
    String? language,
    String? year,
    String? playCount,
    String? explicitContent,
    String? listCount,
    String? listType,
    String? list,
    NewAlbumMoreInfo? moreInfo,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return NewAlbum(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      headerDesc: headerDesc ?? this.headerDesc,
      type: type ?? this.type,
      permaUrl: permaUrl ?? this.permaUrl,
      image: image ?? this.image,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      moreInfo: moreInfo ?? this.moreInfo,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory NewAlbum.fromJson(Map<dynamic, dynamic> json) {
    return NewAlbum(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      headerDesc: json["header_desc"],
      type: json["type"],
      permaUrl: json["perma_url"],
      image: json["image"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      explicitContent: json["explicit_content"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      moreInfo: json["more_info"] == null
          ? null
          : NewAlbumMoreInfo.fromJson(json["more_info"]),
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "header_desc": headerDesc,
        "type": type,
        "perma_url": permaUrl,
        "image": image,
        "language": language,
        "year": year,
        "play_count": playCount,
        "explicit_content": explicitContent,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "more_info": moreInfo?.toJson(),
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $headerDesc, $type, $permaUrl, $image, $language, $year, $playCount, $explicitContent, $listCount, $listType, $list, $moreInfo, $buttonTooltipInfo, ";
  }
}

class NewAlbumMoreInfo {
  NewAlbumMoreInfo({
    required this.music,
    required this.albumId,
    required this.album,
    required this.label,
    required this.origin,
    required this.isDolbyContent,
    required this.the320Kbps,
    required this.encryptedMediaUrl,
    required this.encryptedCacheUrl,
    required this.encryptedDrmCacheUrl,
    required this.encryptedDrmMediaUrl,
    required this.albumUrl,
    required this.duration,
    required this.rights,
    required this.cacheState,
    required this.hasLyrics,
    required this.lyricsSnippet,
    required this.starred,
    required this.copyrightText,
    required this.artistMap,
    required this.releaseDate,
    required this.labelUrl,
    required this.trillerAvailable,
    required this.requestJiotuneFlag,
    required this.webp,
    required this.songCount,
    required this.vcode,
    required this.vlink,
  });

  final String? music;
  final String? albumId;
  final String? album;
  final String? label;
  final String? origin;
  final bool? isDolbyContent;
  final String? the320Kbps;
  final String? encryptedMediaUrl;
  final String? encryptedCacheUrl;
  final String? encryptedDrmCacheUrl;
  final String? encryptedDrmMediaUrl;
  final String? albumUrl;
  final String? duration;
  final PurpleRights? rights;
  final String? cacheState;
  final String? hasLyrics;
  final String? lyricsSnippet;
  final String? starred;
  final String? copyrightText;
  final ArtistMap? artistMap;
  final DateTime? releaseDate;
  final String? labelUrl;
  final bool? trillerAvailable;
  final bool? requestJiotuneFlag;
  final String? webp;
  final String? songCount;
  final String? vcode;
  final String? vlink;

  NewAlbumMoreInfo copyWith({
    String? music,
    String? albumId,
    String? album,
    String? label,
    String? origin,
    bool? isDolbyContent,
    String? the320Kbps,
    String? encryptedMediaUrl,
    String? encryptedCacheUrl,
    String? encryptedDrmCacheUrl,
    String? encryptedDrmMediaUrl,
    String? albumUrl,
    String? duration,
    PurpleRights? rights,
    String? cacheState,
    String? hasLyrics,
    String? lyricsSnippet,
    String? starred,
    String? copyrightText,
    ArtistMap? artistMap,
    DateTime? releaseDate,
    String? labelUrl,
    bool? trillerAvailable,
    bool? requestJiotuneFlag,
    String? webp,
    String? songCount,
    String? vcode,
    String? vlink,
  }) {
    return NewAlbumMoreInfo(
      music: music ?? this.music,
      albumId: albumId ?? this.albumId,
      album: album ?? this.album,
      label: label ?? this.label,
      origin: origin ?? this.origin,
      isDolbyContent: isDolbyContent ?? this.isDolbyContent,
      the320Kbps: the320Kbps ?? this.the320Kbps,
      encryptedMediaUrl: encryptedMediaUrl ?? this.encryptedMediaUrl,
      encryptedCacheUrl: encryptedCacheUrl ?? this.encryptedCacheUrl,
      encryptedDrmCacheUrl: encryptedDrmCacheUrl ?? this.encryptedDrmCacheUrl,
      encryptedDrmMediaUrl: encryptedDrmMediaUrl ?? this.encryptedDrmMediaUrl,
      albumUrl: albumUrl ?? this.albumUrl,
      duration: duration ?? this.duration,
      rights: rights ?? this.rights,
      cacheState: cacheState ?? this.cacheState,
      hasLyrics: hasLyrics ?? this.hasLyrics,
      lyricsSnippet: lyricsSnippet ?? this.lyricsSnippet,
      starred: starred ?? this.starred,
      copyrightText: copyrightText ?? this.copyrightText,
      artistMap: artistMap ?? this.artistMap,
      releaseDate: releaseDate ?? this.releaseDate,
      labelUrl: labelUrl ?? this.labelUrl,
      trillerAvailable: trillerAvailable ?? this.trillerAvailable,
      requestJiotuneFlag: requestJiotuneFlag ?? this.requestJiotuneFlag,
      webp: webp ?? this.webp,
      songCount: songCount ?? this.songCount,
      vcode: vcode ?? this.vcode,
      vlink: vlink ?? this.vlink,
    );
  }

  factory NewAlbumMoreInfo.fromJson(Map<String, dynamic> json) {
    return NewAlbumMoreInfo(
      music: json["music"],
      albumId: json["album_id"],
      album: json["album"],
      label: json["label"],
      origin: json["origin"],
      isDolbyContent: json["is_dolby_content"],
      the320Kbps: json["320kbps"],
      encryptedMediaUrl: json["encrypted_media_url"],
      encryptedCacheUrl: json["encrypted_cache_url"],
      encryptedDrmCacheUrl: json["encrypted_drm_cache_url"],
      encryptedDrmMediaUrl: json["encrypted_drm_media_url"],
      albumUrl: json["album_url"],
      duration: json["duration"],
      rights:
          json["rights"] == null ? null : PurpleRights.fromJson(json["rights"]),
      cacheState: json["cache_state"],
      hasLyrics: json["has_lyrics"],
      lyricsSnippet: json["lyrics_snippet"],
      starred: json["starred"],
      copyrightText: json["copyright_text"],
      artistMap: json["artistMap"] == null
          ? null
          : ArtistMap.fromJson(json["artistMap"]),
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      labelUrl: json["label_url"],
      trillerAvailable: json["triller_available"],
      requestJiotuneFlag: json["request_jiotune_flag"],
      webp: json["webp"],
      songCount: json["song_count"],
      vcode: json["vcode"],
      vlink: json["vlink"],
    );
  }

  Map<String, dynamic> toJson() => {
        "music": music,
        "album_id": albumId,
        "album": album,
        "label": label,
        "origin": origin,
        "is_dolby_content": isDolbyContent,
        "320kbps": the320Kbps,
        "encrypted_media_url": encryptedMediaUrl,
        "encrypted_cache_url": encryptedCacheUrl,
        "encrypted_drm_cache_url": encryptedDrmCacheUrl,
        "encrypted_drm_media_url": encryptedDrmMediaUrl,
        "album_url": albumUrl,
        "duration": duration,
        "rights": rights?.toJson(),
        "cache_state": cacheState,
        "has_lyrics": hasLyrics,
        "lyrics_snippet": lyricsSnippet,
        "starred": starred,
        "copyright_text": copyrightText,
        "artistMap": artistMap?.toJson(),
        "release_date": releaseDate.toString(),
        "label_url": labelUrl,
        "triller_available": trillerAvailable,
        "request_jiotune_flag": requestJiotuneFlag,
        "webp": webp,
        "song_count": songCount,
        "vcode": vcode,
        "vlink": vlink,
      };

  @override
  String toString() {
    return "$music, $albumId, $album, $label, $origin, $isDolbyContent, $the320Kbps, $encryptedMediaUrl, $encryptedCacheUrl, $encryptedDrmCacheUrl, $encryptedDrmMediaUrl, $albumUrl, $duration, $rights, $cacheState, $hasLyrics, $lyricsSnippet, $starred, $copyrightText, $artistMap, $releaseDate, $labelUrl, $trillerAvailable, $requestJiotuneFlag, $webp, $songCount, $vcode, $vlink, ";
  }
}

class ArtistMap {
  ArtistMap({
    required this.primaryArtists,
    required this.featuredArtists,
    required this.artists,
  });

  final List<Artist> primaryArtists;
  final List<dynamic> featuredArtists;
  final List<Artist> artists;

  ArtistMap copyWith({
    List<Artist>? primaryArtists,
    List<dynamic>? featuredArtists,
    List<Artist>? artists,
  }) {
    return ArtistMap(
      primaryArtists: primaryArtists ?? this.primaryArtists,
      featuredArtists: featuredArtists ?? this.featuredArtists,
      artists: artists ?? this.artists,
    );
  }

  factory ArtistMap.fromJson(Map<String, dynamic> json) {
    return ArtistMap(
      primaryArtists: json["primary_artists"] == null
          ? []
          : List<Artist>.from(
              json["primary_artists"]!.map((x) => Artist.fromJson(x))),
      featuredArtists: json["featured_artists"] == null
          ? []
          : List<dynamic>.from(json["featured_artists"]!.map((x) => x)),
      artists: json["artists"] == null
          ? []
          : List<Artist>.from(json["artists"]!.map((x) => Artist.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "primary_artists": primaryArtists.map((x) => x.toJson()).toList(),
        "featured_artists": featuredArtists.map((x) => x).toList(),
        "artists": artists.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$primaryArtists, $featuredArtists, $artists, ";
  }
}

class Artist {
  Artist({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
    required this.type,
    required this.permaUrl,
  });

  final String? id;
  final String? name;
  final String? role;
  final String? image;
  final String? type;
  final String? permaUrl;

  Artist copyWith({
    String? id,
    String? name,
    String? role,
    String? image,
    String? type,
    String? permaUrl,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      image: image ?? this.image,
      type: type ?? this.type,
      permaUrl: permaUrl ?? this.permaUrl,
    );
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json["id"],
      name: json["name"],
      role: json["role"],
      image: json["image"],
      type: json["type"],
      permaUrl: json["perma_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "image": image,
        "type": type,
        "perma_url": permaUrl,
      };

  @override
  String toString() {
    return "$id, $name, $role, $image, $type, $permaUrl, ";
  }
}

class PurpleRights {
  PurpleRights({
    required this.code,
    required this.cacheable,
    required this.deleteCachedObject,
    required this.reason,
  });

  final String? code;
  final String? cacheable;
  final String? deleteCachedObject;
  final String? reason;

  PurpleRights copyWith({
    String? code,
    String? cacheable,
    String? deleteCachedObject,
    String? reason,
  }) {
    return PurpleRights(
      code: code ?? this.code,
      cacheable: cacheable ?? this.cacheable,
      deleteCachedObject: deleteCachedObject ?? this.deleteCachedObject,
      reason: reason ?? this.reason,
    );
  }

  factory PurpleRights.fromJson(Map<String, dynamic> json) {
    return PurpleRights(
      code: json["code"],
      cacheable: json["cacheable"],
      deleteCachedObject: json["delete_cached_object"],
      reason: json["reason"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "cacheable": cacheable,
        "delete_cached_object": deleteCachedObject,
        "reason": reason,
      };

  @override
  String toString() {
    return "$code, $cacheable, $deleteCachedObject, $reason, ";
  }
}

class NewTrending {
  NewTrending({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.headerDesc,
    required this.type,
    required this.permaUrl,
    required this.image,
    required this.language,
    required this.year,
    required this.playCount,
    required this.explicitContent,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.moreInfo,
    required this.modules,
    required this.buttonTooltipInfo,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? headerDesc;
  final String? type;
  final String? permaUrl;
  final String? image;
  final String? language;
  final String? year;
  final String? playCount;
  final String? explicitContent;
  final String? listCount;
  final String? listType;
  final String? list;
  final NewTrendingMoreInfo? moreInfo;
  final dynamic modules;
  final List<dynamic> buttonTooltipInfo;

  NewTrending copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? headerDesc,
    String? type,
    String? permaUrl,
    String? image,
    String? language,
    String? year,
    String? playCount,
    String? explicitContent,
    String? listCount,
    String? listType,
    String? list,
    NewTrendingMoreInfo? moreInfo,
    dynamic modules,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return NewTrending(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      headerDesc: headerDesc ?? this.headerDesc,
      type: type ?? this.type,
      permaUrl: permaUrl ?? this.permaUrl,
      image: image ?? this.image,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      moreInfo: moreInfo ?? this.moreInfo,
      modules: modules ?? this.modules,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory NewTrending.fromJson(Map<dynamic, dynamic> json) {
    return NewTrending(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      headerDesc: json["header_desc"],
      type: json["type"],
      permaUrl: json["perma_url"],
      image: json["image"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      explicitContent: json["explicit_content"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      moreInfo: json["more_info"] == null
          ? null
          : NewTrendingMoreInfo.fromJson(json["more_info"]),
      modules: json["modules"],
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "header_desc": headerDesc,
        "type": type,
        "perma_url": permaUrl,
        "image": image,
        "language": language,
        "year": year,
        "play_count": playCount,
        "explicit_content": explicitContent,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "more_info": moreInfo?.toJson(),
        "modules": modules,
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $headerDesc, $type, $permaUrl, $image, $language, $year, $playCount, $explicitContent, $listCount, $listType, $list, $moreInfo, $modules, $buttonTooltipInfo, ";
  }
}

class NewTrendingMoreInfo {
  NewTrendingMoreInfo({
    required this.releaseDate,
    required this.songCount,
    required this.artistMap,
    required this.listid,
    required this.isWeekly,
    required this.listname,
    required this.firstname,
    required this.followerCount,
    required this.fanCount,
    required this.music,
    required this.albumId,
    required this.album,
    required this.label,
    required this.origin,
    required this.isDolbyContent,
    required this.the320Kbps,
    required this.encryptedMediaUrl,
    required this.encryptedCacheUrl,
    required this.encryptedDrmCacheUrl,
    required this.encryptedDrmMediaUrl,
    required this.albumUrl,
    required this.duration,
    required this.rights,
    required this.cacheState,
    required this.hasLyrics,
    required this.lyricsSnippet,
    required this.starred,
    required this.copyrightText,
    required this.labelUrl,
    required this.vcode,
    required this.vlink,
    required this.trillerAvailable,
    required this.requestJiotuneFlag,
    required this.webp,
  });

  final DateTime? releaseDate;
  final String? songCount;
  final ArtistMap? artistMap;
  final String? listid;
  final String? isWeekly;
  final String? listname;
  final String? firstname;
  final String? followerCount;
  final String? fanCount;
  final String? music;
  final String? albumId;
  final String? album;
  final String? label;
  final String? origin;
  final bool? isDolbyContent;
  final String? the320Kbps;
  final String? encryptedMediaUrl;
  final String? encryptedCacheUrl;
  final String? encryptedDrmCacheUrl;
  final String? encryptedDrmMediaUrl;
  final String? albumUrl;
  final String? duration;
  final FluffyRights? rights;
  final String? cacheState;
  final String? hasLyrics;
  final String? lyricsSnippet;
  final String? starred;
  final String? copyrightText;
  final String? labelUrl;
  final String? vcode;
  final String? vlink;
  final bool? trillerAvailable;
  final bool? requestJiotuneFlag;
  final String? webp;

  NewTrendingMoreInfo copyWith({
    DateTime? releaseDate,
    String? songCount,
    ArtistMap? artistMap,
    String? listid,
    String? isWeekly,
    String? listname,
    String? firstname,
    String? followerCount,
    String? fanCount,
    String? music,
    String? albumId,
    String? album,
    String? label,
    String? origin,
    bool? isDolbyContent,
    String? the320Kbps,
    String? encryptedMediaUrl,
    String? encryptedCacheUrl,
    String? encryptedDrmCacheUrl,
    String? encryptedDrmMediaUrl,
    String? albumUrl,
    String? duration,
    FluffyRights? rights,
    String? cacheState,
    String? hasLyrics,
    String? lyricsSnippet,
    String? starred,
    String? copyrightText,
    String? labelUrl,
    String? vcode,
    String? vlink,
    bool? trillerAvailable,
    bool? requestJiotuneFlag,
    String? webp,
  }) {
    return NewTrendingMoreInfo(
      releaseDate: releaseDate ?? this.releaseDate,
      songCount: songCount ?? this.songCount,
      artistMap: artistMap ?? this.artistMap,
      listid: listid ?? this.listid,
      isWeekly: isWeekly ?? this.isWeekly,
      listname: listname ?? this.listname,
      firstname: firstname ?? this.firstname,
      followerCount: followerCount ?? this.followerCount,
      fanCount: fanCount ?? this.fanCount,
      music: music ?? this.music,
      albumId: albumId ?? this.albumId,
      album: album ?? this.album,
      label: label ?? this.label,
      origin: origin ?? this.origin,
      isDolbyContent: isDolbyContent ?? this.isDolbyContent,
      the320Kbps: the320Kbps ?? this.the320Kbps,
      encryptedMediaUrl: encryptedMediaUrl ?? this.encryptedMediaUrl,
      encryptedCacheUrl: encryptedCacheUrl ?? this.encryptedCacheUrl,
      encryptedDrmCacheUrl: encryptedDrmCacheUrl ?? this.encryptedDrmCacheUrl,
      encryptedDrmMediaUrl: encryptedDrmMediaUrl ?? this.encryptedDrmMediaUrl,
      albumUrl: albumUrl ?? this.albumUrl,
      duration: duration ?? this.duration,
      rights: rights ?? this.rights,
      cacheState: cacheState ?? this.cacheState,
      hasLyrics: hasLyrics ?? this.hasLyrics,
      lyricsSnippet: lyricsSnippet ?? this.lyricsSnippet,
      starred: starred ?? this.starred,
      copyrightText: copyrightText ?? this.copyrightText,
      labelUrl: labelUrl ?? this.labelUrl,
      vcode: vcode ?? this.vcode,
      vlink: vlink ?? this.vlink,
      trillerAvailable: trillerAvailable ?? this.trillerAvailable,
      requestJiotuneFlag: requestJiotuneFlag ?? this.requestJiotuneFlag,
      webp: webp ?? this.webp,
    );
  }

  factory NewTrendingMoreInfo.fromJson(Map<String, dynamic> json) {
    return NewTrendingMoreInfo(
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      songCount: json["song_count"],
      artistMap: json["artistMap"] == null
          ? null
          : ArtistMap.fromJson(json["artistMap"]),
      listid: json["listid"],
      isWeekly: json["isWeekly"],
      listname: json["listname"],
      firstname: json["firstname"],
      followerCount: json["follower_count"],
      fanCount: json["fan_count"],
      music: json["music"],
      albumId: json["album_id"],
      album: json["album"],
      label: json["label"],
      origin: json["origin"],
      isDolbyContent: json["is_dolby_content"],
      the320Kbps: json["320kbps"],
      encryptedMediaUrl: json["encrypted_media_url"],
      encryptedCacheUrl: json["encrypted_cache_url"],
      encryptedDrmCacheUrl: json["encrypted_drm_cache_url"],
      encryptedDrmMediaUrl: json["encrypted_drm_media_url"],
      albumUrl: json["album_url"],
      duration: json["duration"],
      rights:
          json["rights"] == null ? null : FluffyRights.fromJson(json["rights"]),
      cacheState: json["cache_state"],
      hasLyrics: json["has_lyrics"],
      lyricsSnippet: json["lyrics_snippet"],
      starred: json["starred"],
      copyrightText: json["copyright_text"],
      labelUrl: json["label_url"],
      vcode: json["vcode"],
      vlink: json["vlink"],
      trillerAvailable: json["triller_available"],
      requestJiotuneFlag: json["request_jiotune_flag"],
      webp: json["webp"],
    );
  }

  Map<String, dynamic> toJson() => {
        "release_date": releaseDate.toString(),
        "song_count": songCount,
        "artistMap": artistMap?.toJson(),
        "listid": listid,
        "isWeekly": isWeekly,
        "listname": listname,
        "firstname": firstname,
        "follower_count": followerCount,
        "fan_count": fanCount,
        "music": music,
        "album_id": albumId,
        "album": album,
        "label": label,
        "origin": origin,
        "is_dolby_content": isDolbyContent,
        "320kbps": the320Kbps,
        "encrypted_media_url": encryptedMediaUrl,
        "encrypted_cache_url": encryptedCacheUrl,
        "encrypted_drm_cache_url": encryptedDrmCacheUrl,
        "encrypted_drm_media_url": encryptedDrmMediaUrl,
        "album_url": albumUrl,
        "duration": duration,
        "rights": rights?.toJson(),
        "cache_state": cacheState,
        "has_lyrics": hasLyrics,
        "lyrics_snippet": lyricsSnippet,
        "starred": starred,
        "copyright_text": copyrightText,
        "label_url": labelUrl,
        "vcode": vcode,
        "vlink": vlink,
        "triller_available": trillerAvailable,
        "request_jiotune_flag": requestJiotuneFlag,
        "webp": webp,
      };

  @override
  String toString() {
    return "$releaseDate, $songCount, $artistMap, $listid, $isWeekly, $listname, $firstname, $followerCount, $fanCount, $music, $albumId, $album, $label, $origin, $isDolbyContent, $the320Kbps, $encryptedMediaUrl, $encryptedCacheUrl, $encryptedDrmCacheUrl, $encryptedDrmMediaUrl, $albumUrl, $duration, $rights, $cacheState, $hasLyrics, $lyricsSnippet, $starred, $copyrightText, $labelUrl, $vcode, $vlink, $trillerAvailable, $requestJiotuneFlag, $webp, ";
  }
}

class FluffyRights {
  FluffyRights({
    required this.code,
    required this.cacheable,
  });

  final String? code;
  final String? cacheable;

  FluffyRights copyWith({
    String? code,
    String? cacheable,
  }) {
    return FluffyRights(
      code: code ?? this.code,
      cacheable: cacheable ?? this.cacheable,
    );
  }

  factory FluffyRights.fromJson(Map<String, dynamic> json) {
    return FluffyRights(
      code: json["code"],
      cacheable: json["cacheable"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "cacheable": cacheable,
      };

  @override
  String toString() {
    return "$code, $cacheable, ";
  }
}

class PromoVxData107Element {
  PromoVxData107Element({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final PromoVxData107MoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;

  PromoVxData107Element copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    PromoVxData107MoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
  }) {
    return PromoVxData107Element(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
    );
  }

  factory PromoVxData107Element.fromJson(Map<String, dynamic> json) {
    return PromoVxData107Element(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : PromoVxData107MoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, ";
  }
}

class PromoVxData107MoreInfo {
  PromoVxData107MoreInfo({
    required this.squareImage,
  });

  final String? squareImage;

  PromoVxData107MoreInfo copyWith({
    String? squareImage,
  }) {
    return PromoVxData107MoreInfo(
      squareImage: squareImage ?? this.squareImage,
    );
  }

  factory PromoVxData107MoreInfo.fromJson(Map<String, dynamic> json) {
    return PromoVxData107MoreInfo(
      squareImage: json["square_image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "square_image": squareImage,
      };

  @override
  String toString() {
    return "$squareImage, ";
  }
}

class PromoVxData113Element {
  PromoVxData113Element({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.headerDesc,
    required this.type,
    required this.permaUrl,
    required this.image,
    required this.language,
    required this.year,
    required this.playCount,
    required this.explicitContent,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.moreInfo,
    required this.modules,
    required this.buttonTooltipInfo,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? headerDesc;
  final String? type;
  final String? permaUrl;
  final String? image;
  final String? language;
  final String? year;
  final String? playCount;
  final String? explicitContent;
  final String? listCount;
  final String? listType;
  final String? list;
  final PromoVxData113MoreInfo? moreInfo;
  final dynamic modules;
  final List<dynamic> buttonTooltipInfo;

  PromoVxData113Element copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? headerDesc,
    String? type,
    String? permaUrl,
    String? image,
    String? language,
    String? year,
    String? playCount,
    String? explicitContent,
    String? listCount,
    String? listType,
    String? list,
    PromoVxData113MoreInfo? moreInfo,
    dynamic modules,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return PromoVxData113Element(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      headerDesc: headerDesc ?? this.headerDesc,
      type: type ?? this.type,
      permaUrl: permaUrl ?? this.permaUrl,
      image: image ?? this.image,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      moreInfo: moreInfo ?? this.moreInfo,
      modules: modules ?? this.modules,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory PromoVxData113Element.fromJson(Map<String, dynamic> json) {
    return PromoVxData113Element(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      headerDesc: json["header_desc"],
      type: json["type"],
      permaUrl: json["perma_url"],
      image: json["image"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      explicitContent: json["explicit_content"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      moreInfo: json["more_info"] == null
          ? null
          : PromoVxData113MoreInfo.fromJson(json["more_info"]),
      modules: json["modules"],
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "header_desc": headerDesc,
        "type": type,
        "perma_url": permaUrl,
        "image": image,
        "language": language,
        "year": year,
        "play_count": playCount,
        "explicit_content": explicitContent,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "more_info": moreInfo?.toJson(),
        "modules": modules,
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $headerDesc, $type, $permaUrl, $image, $language, $year, $playCount, $explicitContent, $listCount, $listType, $list, $moreInfo, $modules, $buttonTooltipInfo, ";
  }
}

class PromoVxData113MoreInfo {
  PromoVxData113MoreInfo({
    required this.releaseYear,
  });

  final num? releaseYear;

  PromoVxData113MoreInfo copyWith({
    num? releaseYear,
  }) {
    return PromoVxData113MoreInfo(
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }

  factory PromoVxData113MoreInfo.fromJson(Map<String, dynamic> json) {
    return PromoVxData113MoreInfo(
      releaseYear: json["release_year"],
    );
  }

  Map<String, dynamic> toJson() => {
        "release_year": releaseYear,
      };

  @override
  String toString() {
    return "$releaseYear, ";
  }
}

class PromoVxData140 {
  PromoVxData140({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
    required this.headerDesc,
    required this.language,
    required this.year,
    required this.playCount,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.modules,
    required this.buttonTooltipInfo,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final PromoVxData140MoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;
  final String? headerDesc;
  final String? language;
  final String? year;
  final String? playCount;
  final String? listCount;
  final String? listType;
  final String? list;
  final dynamic modules;
  final List<dynamic> buttonTooltipInfo;

  PromoVxData140 copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    PromoVxData140MoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
    String? headerDesc,
    String? language,
    String? year,
    String? playCount,
    String? listCount,
    String? listType,
    String? list,
    dynamic modules,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return PromoVxData140(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
      headerDesc: headerDesc ?? this.headerDesc,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      modules: modules ?? this.modules,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory PromoVxData140.fromJson(Map<String, dynamic> json) {
    return PromoVxData140(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : PromoVxData140MoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
      headerDesc: json["header_desc"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      modules: json["modules"],
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
        "header_desc": headerDesc,
        "language": language,
        "year": year,
        "play_count": playCount,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "modules": modules,
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, $headerDesc, $language, $year, $playCount, $listCount, $listType, $list, $modules, $buttonTooltipInfo, ";
  }
}

class PromoVxData140MoreInfo {
  PromoVxData140MoreInfo({
    required this.videoAvailable,
    required this.subTypes,
    required this.releaseYear,
  });

  final dynamic videoAvailable;
  final List<dynamic> subTypes;
  final num? releaseYear;

  PromoVxData140MoreInfo copyWith({
    dynamic videoAvailable,
    List<dynamic>? subTypes,
    num? releaseYear,
  }) {
    return PromoVxData140MoreInfo(
      videoAvailable: videoAvailable ?? this.videoAvailable,
      subTypes: subTypes ?? this.subTypes,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }

  factory PromoVxData140MoreInfo.fromJson(Map<String, dynamic> json) {
    return PromoVxData140MoreInfo(
      videoAvailable: json["video_available"],
      subTypes: json["sub_types"] == null
          ? []
          : List<dynamic>.from(json["sub_types"]!.map((x) => x)),
      releaseYear: json["release_year"],
    );
  }

  Map<String, dynamic> toJson() => {
        "video_available": videoAvailable,
        "sub_types": subTypes.map((x) => x).toList(),
        "release_year": releaseYear,
      };

  @override
  String toString() {
    return "$videoAvailable, $subTypes, $releaseYear, ";
  }
}

class PromoVxData164Element {
  PromoVxData164Element({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
    required this.headerDesc,
    required this.language,
    required this.year,
    required this.playCount,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.modules,
    required this.buttonTooltipInfo,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final PromoVxData164MoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;
  final String? headerDesc;
  final String? language;
  final String? year;
  final String? playCount;
  final String? listCount;
  final String? listType;
  final String? list;
  final dynamic modules;
  final List<dynamic> buttonTooltipInfo;

  PromoVxData164Element copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    PromoVxData164MoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
    String? headerDesc,
    String? language,
    String? year,
    String? playCount,
    String? listCount,
    String? listType,
    String? list,
    dynamic modules,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return PromoVxData164Element(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
      headerDesc: headerDesc ?? this.headerDesc,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      modules: modules ?? this.modules,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory PromoVxData164Element.fromJson(Map<String, dynamic> json) {
    return PromoVxData164Element(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : PromoVxData164MoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
      headerDesc: json["header_desc"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      modules: json["modules"],
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
        "header_desc": headerDesc,
        "language": language,
        "year": year,
        "play_count": playCount,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "modules": modules,
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, $headerDesc, $language, $year, $playCount, $listCount, $listType, $list, $modules, $buttonTooltipInfo, ";
  }
}

class PromoVxData164MoreInfo {
  PromoVxData164MoreInfo({
    required this.videoAvailable,
    required this.subTypes,
    required this.position,
    required this.editorialLanguage,
    required this.releaseYear,
  });

  final dynamic videoAvailable;
  final List<dynamic> subTypes;
  final String? position;
  final String? editorialLanguage;
  final num? releaseYear;

  PromoVxData164MoreInfo copyWith({
    dynamic videoAvailable,
    List<dynamic>? subTypes,
    String? position,
    String? editorialLanguage,
    num? releaseYear,
  }) {
    return PromoVxData164MoreInfo(
      videoAvailable: videoAvailable ?? this.videoAvailable,
      subTypes: subTypes ?? this.subTypes,
      position: position ?? this.position,
      editorialLanguage: editorialLanguage ?? this.editorialLanguage,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }

  factory PromoVxData164MoreInfo.fromJson(Map<String, dynamic> json) {
    return PromoVxData164MoreInfo(
      videoAvailable: json["video_available"],
      subTypes: json["sub_types"] == null
          ? []
          : List<dynamic>.from(json["sub_types"]!.map((x) => x)),
      position: json["position"],
      editorialLanguage: json["editorial_language"],
      releaseYear: json["release_year"],
    );
  }

  Map<String, dynamic> toJson() => {
        "video_available": videoAvailable,
        "sub_types": subTypes.map((x) => x).toList(),
        "position": position,
        "editorial_language": editorialLanguage,
        "release_year": releaseYear,
      };

  @override
  String toString() {
    return "$videoAvailable, $subTypes, $position, $editorialLanguage, $releaseYear, ";
  }
}

class PromoVxData176Element {
  PromoVxData176Element({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final PromoVxData164MoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;

  PromoVxData176Element copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    PromoVxData164MoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
  }) {
    return PromoVxData176Element(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
    );
  }

  factory PromoVxData176Element.fromJson(Map<String, dynamic> json) {
    return PromoVxData176Element(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : PromoVxData164MoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, ";
  }
}

class PromoVxData207 {
  PromoVxData207({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
    required this.headerDesc,
    required this.language,
    required this.year,
    required this.playCount,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.modules,
    required this.buttonTooltipInfo,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final PromoVxData207MoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;
  final String? headerDesc;
  final String? language;
  final String? year;
  final String? playCount;
  final String? listCount;
  final String? listType;
  final String? list;
  final dynamic modules;
  final List<dynamic> buttonTooltipInfo;

  PromoVxData207 copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    PromoVxData207MoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
    String? headerDesc,
    String? language,
    String? year,
    String? playCount,
    String? listCount,
    String? listType,
    String? list,
    dynamic modules,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return PromoVxData207(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
      headerDesc: headerDesc ?? this.headerDesc,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      modules: modules ?? this.modules,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory PromoVxData207.fromJson(Map<String, dynamic> json) {
    return PromoVxData207(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : PromoVxData207MoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
      headerDesc: json["header_desc"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      modules: json["modules"],
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
        "header_desc": headerDesc,
        "language": language,
        "year": year,
        "play_count": playCount,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "modules": modules,
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, $headerDesc, $language, $year, $playCount, $listCount, $listType, $list, $modules, $buttonTooltipInfo, ";
  }
}

class PromoVxData207MoreInfo {
  PromoVxData207MoreInfo({
    required this.videoAvailable,
    required this.subTypes,
    required this.albumId,
    required this.multipleTunes,
    required this.releaseYear,
  });

  final dynamic videoAvailable;
  final List<dynamic> subTypes;
  final String? albumId;
  final List<MultipleTune> multipleTunes;
  final num? releaseYear;

  PromoVxData207MoreInfo copyWith({
    dynamic videoAvailable,
    List<dynamic>? subTypes,
    String? albumId,
    List<MultipleTune>? multipleTunes,
    num? releaseYear,
  }) {
    return PromoVxData207MoreInfo(
      videoAvailable: videoAvailable ?? this.videoAvailable,
      subTypes: subTypes ?? this.subTypes,
      albumId: albumId ?? this.albumId,
      multipleTunes: multipleTunes ?? this.multipleTunes,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }

  factory PromoVxData207MoreInfo.fromJson(Map<String, dynamic> json) {
    return PromoVxData207MoreInfo(
      videoAvailable: json["video_available"],
      subTypes: json["sub_types"] == null
          ? []
          : List<dynamic>.from(json["sub_types"]!.map((x) => x)),
      albumId: json["album_id"],
      multipleTunes: json["multiple_tunes"] == null
          ? []
          : List<MultipleTune>.from(
              json["multiple_tunes"]!.map((x) => MultipleTune.fromJson(x))),
      releaseYear: json["release_year"],
    );
  }

  Map<String, dynamic> toJson() => {
        "video_available": videoAvailable,
        "sub_types": subTypes.map((x) => x).toList(),
        "album_id": albumId,
        "multiple_tunes": multipleTunes.map((x) => x.toJson()).toList(),
        "release_year": releaseYear,
      };

  @override
  String toString() {
    return "$videoAvailable, $subTypes, $albumId, $multipleTunes, $releaseYear, ";
  }
}

class MultipleTune {
  MultipleTune({
    required this.id,
    required this.title,
    required this.type,
    required this.subtype,
    required this.vcode,
    required this.vlink,
  });

  final String? id;
  final String? title;
  final String? type;
  final String? subtype;
  final String? vcode;
  final String? vlink;

  MultipleTune copyWith({
    String? id,
    String? title,
    String? type,
    String? subtype,
    String? vcode,
    String? vlink,
  }) {
    return MultipleTune(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      vcode: vcode ?? this.vcode,
      vlink: vlink ?? this.vlink,
    );
  }

  factory MultipleTune.fromJson(Map<String, dynamic> json) {
    return MultipleTune(
      id: json["id"],
      title: json["title"],
      type: json["type"],
      subtype: json["subtype"],
      vcode: json["vcode"],
      vlink: json["vlink"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "subtype": subtype,
        "vcode": vcode,
        "vlink": vlink,
      };

  @override
  String toString() {
    return "$id, $title, $type, $subtype, $vcode, $vlink, ";
  }
}

class Radio {
  Radio({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final RadioMoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;

  Radio copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    RadioMoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
  }) {
    return Radio(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
    );
  }

  factory Radio.fromJson(Map<String, dynamic> json) {
    return Radio(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : RadioMoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, ";
  }
}

class RadioMoreInfo {
  RadioMoreInfo({
    required this.description,
    required this.featuredStationType,
    required this.query,
    required this.color,
    required this.language,
    required this.stationDisplayText,
  });

  final String? description;
  final String? featuredStationType;
  final String? query;
  final String? color;
  final String? language;
  final String? stationDisplayText;

  RadioMoreInfo copyWith({
    String? description,
    String? featuredStationType,
    String? query,
    String? color,
    String? language,
    String? stationDisplayText,
  }) {
    return RadioMoreInfo(
      description: description ?? this.description,
      featuredStationType: featuredStationType ?? this.featuredStationType,
      query: query ?? this.query,
      color: color ?? this.color,
      language: language ?? this.language,
      stationDisplayText: stationDisplayText ?? this.stationDisplayText,
    );
  }

  factory RadioMoreInfo.fromJson(Map<String, dynamic> json) {
    return RadioMoreInfo(
      description: json["description"],
      featuredStationType: json["featured_station_type"],
      query: json["query"],
      color: json["color"],
      language: json["language"],
      stationDisplayText: json["station_display_text"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "featured_station_type": featuredStationType,
        "query": query,
        "color": color,
        "language": language,
        "station_display_text": stationDisplayText,
      };

  @override
  String toString() {
    return "$description, $featuredStationType, $query, $color, $language, $stationDisplayText, ";
  }
}

class TagMix {
  TagMix({
    required this.subtitle,
    required this.description,
    required this.id,
    required this.title,
    required this.headerDesc,
    required this.type,
    required this.permaUrl,
    required this.image,
    required this.language,
    required this.year,
    required this.playCount,
    required this.explicitContent,
    required this.listCount,
    required this.listType,
    required this.list,
    required this.moreInfo,
    required this.buttonTooltipInfo,
  });

  final String? subtitle;
  final String? description;
  final String? id;
  final String? title;
  final String? headerDesc;
  final String? type;
  final String? permaUrl;
  final String? image;
  final String? language;
  final String? year;
  final String? playCount;
  final String? explicitContent;
  final String? listCount;
  final String? listType;
  final String? list;
  final TagMixMoreInfo? moreInfo;
  final List<dynamic> buttonTooltipInfo;

  TagMix copyWith({
    String? subtitle,
    String? description,
    String? id,
    String? title,
    String? headerDesc,
    String? type,
    String? permaUrl,
    String? image,
    String? language,
    String? year,
    String? playCount,
    String? explicitContent,
    String? listCount,
    String? listType,
    String? list,
    TagMixMoreInfo? moreInfo,
    List<dynamic>? buttonTooltipInfo,
  }) {
    return TagMix(
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      id: id ?? this.id,
      title: title ?? this.title,
      headerDesc: headerDesc ?? this.headerDesc,
      type: type ?? this.type,
      permaUrl: permaUrl ?? this.permaUrl,
      image: image ?? this.image,
      language: language ?? this.language,
      year: year ?? this.year,
      playCount: playCount ?? this.playCount,
      explicitContent: explicitContent ?? this.explicitContent,
      listCount: listCount ?? this.listCount,
      listType: listType ?? this.listType,
      list: list ?? this.list,
      moreInfo: moreInfo ?? this.moreInfo,
      buttonTooltipInfo: buttonTooltipInfo ?? this.buttonTooltipInfo,
    );
  }

  factory TagMix.fromJson(Map<String, dynamic> json) {
    return TagMix(
      subtitle: json["subtitle"],
      description: json["description"],
      id: json["id"],
      title: json["title"],
      headerDesc: json["header_desc"],
      type: json["type"],
      permaUrl: json["perma_url"],
      image: json["image"],
      language: json["language"],
      year: json["year"],
      playCount: json["play_count"],
      explicitContent: json["explicit_content"],
      listCount: json["list_count"],
      listType: json["list_type"],
      list: json["list"],
      moreInfo: json["more_info"] == null
          ? null
          : TagMixMoreInfo.fromJson(json["more_info"]),
      buttonTooltipInfo: json["button_tooltip_info"] == null
          ? []
          : List<dynamic>.from(json["button_tooltip_info"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "subtitle": subtitle,
        "description": description,
        "id": id,
        "title": title,
        "header_desc": headerDesc,
        "type": type,
        "perma_url": permaUrl,
        "image": image,
        "language": language,
        "year": year,
        "play_count": playCount,
        "explicit_content": explicitContent,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "more_info": moreInfo?.toJson(),
        "button_tooltip_info": buttonTooltipInfo.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$subtitle, $description, $id, $title, $headerDesc, $type, $permaUrl, $image, $language, $year, $playCount, $explicitContent, $listCount, $listType, $list, $moreInfo, $buttonTooltipInfo, ";
  }
}

class TagMixMoreInfo {
  TagMixMoreInfo({
    required this.firstname,
    required this.lastname,
    required this.type,
  });

  final String? firstname;
  final String? lastname;
  final String? type;

  TagMixMoreInfo copyWith({
    String? firstname,
    String? lastname,
    String? type,
  }) {
    return TagMixMoreInfo(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      type: type ?? this.type,
    );
  }

  factory TagMixMoreInfo.fromJson(Map<String, dynamic> json) {
    return TagMixMoreInfo(
      firstname: json["firstname"],
      lastname: json["lastname"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "type": type,
      };

  @override
  String toString() {
    return "$firstname, $lastname, $type, ";
  }
}

class TopPlaylist {
  TopPlaylist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaUrl,
    required this.moreInfo,
    required this.explicitContent,
    required this.miniObj,
  });

  final String? id;
  final String? title;
  final String? subtitle;
  final String? type;
  final String? image;
  final String? permaUrl;
  final TopPlaylistMoreInfo? moreInfo;
  final String? explicitContent;
  final bool? miniObj;

  TopPlaylist copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    String? image,
    String? permaUrl,
    TopPlaylistMoreInfo? moreInfo,
    String? explicitContent,
    bool? miniObj,
  }) {
    return TopPlaylist(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      permaUrl: permaUrl ?? this.permaUrl,
      moreInfo: moreInfo ?? this.moreInfo,
      explicitContent: explicitContent ?? this.explicitContent,
      miniObj: miniObj ?? this.miniObj,
    );
  }

  factory TopPlaylist.fromJson(Map<String, dynamic> json) {
    return TopPlaylist(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      type: json["type"],
      image: json["image"],
      permaUrl: json["perma_url"],
      moreInfo: json["more_info"] == null
          ? null
          : TopPlaylistMoreInfo.fromJson(json["more_info"]),
      explicitContent: json["explicit_content"],
      miniObj: json["mini_obj"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
      };

  @override
  String toString() {
    return "$id, $title, $subtitle, $type, $image, $permaUrl, $moreInfo, $explicitContent, $miniObj, ";
  }
}

class TopPlaylistMoreInfo {
  TopPlaylistMoreInfo({
    required this.songCount,
    required this.firstname,
    required this.followerCount,
    required this.lastUpdated,
    required this.uid,
  });

  final String? songCount;
  final String? firstname;
  final String? followerCount;
  final String? lastUpdated;
  final String? uid;

  TopPlaylistMoreInfo copyWith({
    String? songCount,
    String? firstname,
    String? followerCount,
    String? lastUpdated,
    String? uid,
  }) {
    return TopPlaylistMoreInfo(
      songCount: songCount ?? this.songCount,
      firstname: firstname ?? this.firstname,
      followerCount: followerCount ?? this.followerCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      uid: uid ?? this.uid,
    );
  }

  factory TopPlaylistMoreInfo.fromJson(Map<String, dynamic> json) {
    return TopPlaylistMoreInfo(
      songCount: json["song_count"],
      firstname: json["firstname"],
      followerCount: json["follower_count"],
      lastUpdated: json["last_updated"],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "song_count": songCount,
        "firstname": firstname,
        "follower_count": followerCount,
        "last_updated": lastUpdated,
        "uid": uid,
      };

  @override
  String toString() {
    return "$songCount, $firstname, $followerCount, $lastUpdated, $uid, ";
  }
}
