class Rights {
	String? cacheable;
	String? code;
	String? deleteCachedObject;
	String? reason;

	Rights({this.cacheable, this.code, this.deleteCachedObject, this.reason});

	factory Rights.fromJson(Map<String, dynamic> json) => Rights(
				cacheable: json['cacheable'] as String?,
				code: json['code'] as String?,
				deleteCachedObject: json['delete_cached_object'] as String?,
				reason: json['reason'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'cacheable': cacheable,
				'code': code,
				'delete_cached_object': deleteCachedObject,
				'reason': reason,
			};
}
