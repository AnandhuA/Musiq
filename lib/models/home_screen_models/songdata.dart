import 'albums.dart';
import 'artist_recos.dart';
import 'charts.dart';
import 'city_mod.dart';
import 'discover.dart';
import 'global_config.dart';
import 'mixes.dart';
import 'playlists.dart';
import 'promo0.dart';
import 'promo1.dart';
import 'promo10.dart';
import 'promo11.dart';
import 'promo12.dart';
import 'promo13.dart';
import 'promo2.dart';
import 'promo3.dart';
import 'promo4.dart';
import 'promo5.dart';
import 'promo6.dart';
import 'promo7.dart';
import 'promo8.dart';
import 'promo9.dart';
import 'radio.dart';
import 'trending.dart';

class Songdata {
	Albums? albums;
	ArtistRecos? artistRecos;
	Charts? charts;
	CityMod? cityMod;
	Discover? discover;
	GlobalConfig? globalConfig;
	Mixes? mixes;
	Playlists? playlists;
	Promo0? promo0;
	Promo1? promo1;
	Promo10? promo10;
	Promo11? promo11;
	Promo12? promo12;
	Promo13? promo13;
	Promo2? promo2;
	Promo3? promo3;
	Promo4? promo4;
	Promo5? promo5;
	Promo6? promo6;
	Promo7? promo7;
	Promo8? promo8;
	Promo9? promo9;
	Radio? radio;
	Trending? trending;

	Songdata({
		this.albums, 
		this.artistRecos, 
		this.charts, 
		this.cityMod, 
		this.discover, 
		this.globalConfig, 
		this.mixes, 
		this.playlists, 
		this.promo0, 
		this.promo1, 
		this.promo10, 
		this.promo11, 
		this.promo12, 
		this.promo13, 
		this.promo2, 
		this.promo3, 
		this.promo4, 
		this.promo5, 
		this.promo6, 
		this.promo7, 
		this.promo8, 
		this.promo9, 
		this.radio, 
		this.trending, 
	});

	factory Songdata.fromJson(Map<String, dynamic> json) => Songdata(
				albums: json['albums'] == null
						? null
						: Albums.fromJson(json['albums'] as Map<String, dynamic>),
				artistRecos: json['artist_recos'] == null
						? null
						: ArtistRecos.fromJson(json['artist_recos'] as Map<String, dynamic>),
				charts: json['charts'] == null
						? null
						: Charts.fromJson(json['charts'] as Map<String, dynamic>),
				cityMod: json['city_mod'] == null
						? null
						: CityMod.fromJson(json['city_mod'] as Map<String, dynamic>),
				discover: json['discover'] == null
						? null
						: Discover.fromJson(json['discover'] as Map<String, dynamic>),
				globalConfig: json['global_config'] == null
						? null
						: GlobalConfig.fromJson(json['global_config'] as Map<String, dynamic>),
				mixes: json['mixes'] == null
						? null
						: Mixes.fromJson(json['mixes'] as Map<String, dynamic>),
				playlists: json['playlists'] == null
						? null
						: Playlists.fromJson(json['playlists'] as Map<String, dynamic>),
				promo0: json['promo0'] == null
						? null
						: Promo0.fromJson(json['promo0'] as Map<String, dynamic>),
				promo1: json['promo1'] == null
						? null
						: Promo1.fromJson(json['promo1'] as Map<String, dynamic>),
				promo10: json['promo10'] == null
						? null
						: Promo10.fromJson(json['promo10'] as Map<String, dynamic>),
				promo11: json['promo11'] == null
						? null
						: Promo11.fromJson(json['promo11'] as Map<String, dynamic>),
				promo12: json['promo12'] == null
						? null
						: Promo12.fromJson(json['promo12'] as Map<String, dynamic>),
				promo13: json['promo13'] == null
						? null
						: Promo13.fromJson(json['promo13'] as Map<String, dynamic>),
				promo2: json['promo2'] == null
						? null
						: Promo2.fromJson(json['promo2'] as Map<String, dynamic>),
				promo3: json['promo3'] == null
						? null
						: Promo3.fromJson(json['promo3'] as Map<String, dynamic>),
				promo4: json['promo4'] == null
						? null
						: Promo4.fromJson(json['promo4'] as Map<String, dynamic>),
				promo5: json['promo5'] == null
						? null
						: Promo5.fromJson(json['promo5'] as Map<String, dynamic>),
				promo6: json['promo6'] == null
						? null
						: Promo6.fromJson(json['promo6'] as Map<String, dynamic>),
				promo7: json['promo7'] == null
						? null
						: Promo7.fromJson(json['promo7'] as Map<String, dynamic>),
				promo8: json['promo8'] == null
						? null
						: Promo8.fromJson(json['promo8'] as Map<String, dynamic>),
				promo9: json['promo9'] == null
						? null
						: Promo9.fromJson(json['promo9'] as Map<String, dynamic>),
				radio: json['radio'] == null
						? null
						: Radio.fromJson(json['radio'] as Map<String, dynamic>),
				trending: json['trending'] == null
						? null
						: Trending.fromJson(json['trending'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'albums': albums?.toJson(),
				'artist_recos': artistRecos?.toJson(),
				'charts': charts?.toJson(),
				'city_mod': cityMod?.toJson(),
				'discover': discover?.toJson(),
				'global_config': globalConfig?.toJson(),
				'mixes': mixes?.toJson(),
				'playlists': playlists?.toJson(),
				'promo0': promo0?.toJson(),
				'promo1': promo1?.toJson(),
				'promo10': promo10?.toJson(),
				'promo11': promo11?.toJson(),
				'promo12': promo12?.toJson(),
				'promo13': promo13?.toJson(),
				'promo2': promo2?.toJson(),
				'promo3': promo3?.toJson(),
				'promo4': promo4?.toJson(),
				'promo5': promo5?.toJson(),
				'promo6': promo6?.toJson(),
				'promo7': promo7?.toJson(),
				'promo8': promo8?.toJson(),
				'promo9': promo9?.toJson(),
				'radio': radio?.toJson(),
				'trending': trending?.toJson(),
			};
}
