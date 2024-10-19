import 'random_songs_listid.dart';
import 'weekly_top_songs_listid.dart';

class GlobalConfig {
	RandomSongsListid? randomSongsListid;
	WeeklyTopSongsListid? weeklyTopSongsListid;

	GlobalConfig({this.randomSongsListid, this.weeklyTopSongsListid});

	factory GlobalConfig.fromJson(Map<String, dynamic> json) => GlobalConfig(
				randomSongsListid: json['random_songs_listid'] == null
						? null
						: RandomSongsListid.fromJson(json['random_songs_listid'] as Map<String, dynamic>),
				weeklyTopSongsListid: json['weekly_top_songs_listid'] == null
						? null
						: WeeklyTopSongsListid.fromJson(json['weekly_top_songs_listid'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'random_songs_listid': randomSongsListid?.toJson(),
				'weekly_top_songs_listid': weeklyTopSongsListid?.toJson(),
			};
}
