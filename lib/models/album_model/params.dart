class Params {
	String? lang;
	String? type;

	Params({this.lang, this.type});

	factory Params.fromJson(Map<String, dynamic> json) => Params(
				lang: json['lang'] as String?,
				type: json['type'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'lang': lang,
				'type': type,
			};
}
