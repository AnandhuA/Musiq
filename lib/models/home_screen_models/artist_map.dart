import 'artist.dart';
import 'primary_artist.dart';

class ArtistMap {
	List<Artist>? artists;
	List<dynamic>? featuredArtists;
	List<PrimaryArtist>? primaryArtists;

	ArtistMap({this.artists, this.featuredArtists, this.primaryArtists});

	factory ArtistMap.fromJson(Map<String, dynamic> json) => ArtistMap(
				artists: (json['artists'] as List<dynamic>?)
						?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
						.toList(),
				featuredArtists: json['featured_artists'] as List<dynamic>?,
				primaryArtists: (json['primary_artists'] as List<dynamic>?)
						?.map((e) => PrimaryArtist.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'artists': artists?.map((e) => e.toJson()).toList(),
				'featured_artists': featuredArtists,
				'primary_artists': primaryArtists?.map((e) => e.toJson()).toList(),
			};
}
