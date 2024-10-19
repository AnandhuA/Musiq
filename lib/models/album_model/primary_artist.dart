import 'package:musiq/models/song_model/image.dart';


class PrimaryArtist {
	String? id;
	List<Image>? image;
	String? name;
	String? role;
	String? type;
	String? url;

	PrimaryArtist({
		this.id, 
		this.image, 
		this.name, 
		this.role, 
		this.type, 
		this.url, 
	});

	factory PrimaryArtist.fromJson(Map<String, dynamic> json) => PrimaryArtist(
				id: json['id'] as String?,
				image: (json['image'] as List<dynamic>?)
						?.map((e) => Image.fromJson(e as Map<String, dynamic>))
						.toList(),
				name: json['name'] as String?,
				role: json['role'] as String?,
				type: json['type'] as String?,
				url: json['url'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'image': image?.map((e) => e.toJson()).toList(),
				'name': name,
				'role': role,
				'type': type,
				'url': url,
			};
}
