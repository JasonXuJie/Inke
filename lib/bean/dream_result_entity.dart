class DreamResultEntity {
	List<DreamResult> result;
	String reason;
	int total;
	int errorCode;

	DreamResultEntity({this.result, this.reason, this.total, this.errorCode});

	DreamResultEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<DreamResult>();
			(json['result'] as List).forEach((v) { result.add(new DreamResult.fromJson(v)); });
		}
		reason = json['reason'];
		total = json['total'];
		errorCode = json['error_code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
		data['reason'] = this.reason;
		data['total'] = this.total;
		data['error_code'] = this.errorCode;
		return data;
	}
}

class DreamResult {
	String title;
	String type;
	String content;

	DreamResult({this.title, this.type, this.content});

	DreamResult.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		type = json['type'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		return data;
	}
}
