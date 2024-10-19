import 'english.dart';
import 'hindi.dart';

class RandomSongsListid {
	English? english;
	Hindi? hindi;

	RandomSongsListid({this.english, this.hindi});

	factory RandomSongsListid.fromJson(Map<String, dynamic> json) {
		return RandomSongsListid(
			english: json['english'] == null
						? null
						: English.fromJson(json['english'] as Map<String, dynamic>),
			hindi: json['hindi'] == null
						? null
						: Hindi.fromJson(json['hindi'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toJson() => {
				'english': english?.toJson(),
				'hindi': hindi?.toJson(),
			};
}
