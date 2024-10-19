import 'package:musiq/models/home_screen_models/artist_map.dart';
import 'package:musiq/models/song_model/image.dart';
import 'package:musiq/models/song_model/song.dart';

import 'modules.dart';

class Data {
	ArtistMap? artistMap;
	String? copyrightText;
	bool? explicit;
	String? headerDesc;
	String? id;
	List<Image>? image;
	bool? isDolbyContent;
	String? labelUrl;
	String? language;
	int? listCount;
	String? listType;
	Modules? modules;
	String? name;
	int? playCount;
	int? songCount;
	List<Song>? songs;
	String? subtitle;
	String? type;
	String? url;
	int? year;

	Data({
		this.artistMap, 
		this.copyrightText, 
		this.explicit, 
		this.headerDesc, 
		this.id, 
		this.image, 
		this.isDolbyContent, 
		this.labelUrl, 
		this.language, 
		this.listCount, 
		this.listType, 
		this.modules, 
		this.name, 
		this.playCount, 
		this.songCount, 
		this.songs, 
		this.subtitle, 
		this.type, 
		this.url, 
		this.year, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				artistMap: json['artistMap'] == null
						? null
						: ArtistMap.fromJson(json['artistMap'] as Map<String, dynamic>),
				copyrightText: json['copyright_text'] as String?,
				explicit: json['explicit'] as bool?,
				headerDesc: json['header_desc'] as String?,
				id: json['id'] as String?,
				image: (json['image'] as List<dynamic>?)
						?.map((e) => Image.fromJson(e as Map<String, dynamic>))
						.toList(),
				isDolbyContent: json['is_dolby_content'] as bool?,
				labelUrl: json['label_url'] as String?,
				language: json['language'] as String?,
				listCount: json['list_count'] as int?,
				listType: json['list_type'] as String?,
				modules: json['modules'] == null
						? null
						: Modules.fromJson(json['modules'] as Map<String, dynamic>),
				name: json['name'] as String?,
				playCount: json['play_count'] as int?,
				songCount: json['song_count'] as int?,
				songs: (json['songs'] as List<dynamic>?)
						?.map((e) => Song.fromJson(e as Map<String, dynamic>))
						.toList(),
				subtitle: json['subtitle'] as String?,
				type: json['type'] as String?,
				url: json['url'] as String?,
				year: json['year'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'artistMap': artistMap?.toJson(),
				'copyright_text': copyrightText,
				'explicit': explicit,
				'header_desc': headerDesc,
				'id': id,
				'image': image?.map((e) => e.toJson()).toList(),
				'is_dolby_content': isDolbyContent,
				'label_url': labelUrl,
				'language': language,
				'list_count': listCount,
				'list_type': listType,
				'modules': modules?.toJson(),
				'name': name,
				'play_count': playCount,
				'song_count': songCount,
				'songs': songs?.map((e) => e.toJson()).toList(),
				'subtitle': subtitle,
				'type': type,
				'url': url,
				'year': year,
			};
}
