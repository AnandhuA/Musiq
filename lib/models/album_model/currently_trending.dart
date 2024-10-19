import 'params.dart';

class CurrentlyTrending {
	Params? params;
	int? position;
	String? source;
	String? subtitle;
	String? title;

	CurrentlyTrending({
		this.params, 
		this.position, 
		this.source, 
		this.subtitle, 
		this.title, 
	});

	factory CurrentlyTrending.fromJson(Map<String, dynamic> json) {
		return CurrentlyTrending(
			params: json['params'] == null
						? null
						: Params.fromJson(json['params'] as Map<String, dynamic>),
			position: json['position'] as int?,
			source: json['source'] as String?,
			subtitle: json['subtitle'] as String?,
			title: json['title'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'params': params?.toJson(),
				'position': position,
				'source': source,
				'subtitle': subtitle,
				'title': title,
			};
}
