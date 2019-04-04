class HistoryDetailResultEntity {
	List<HistoryDetailResult> result;
	String reason;
	int errorCode;

	HistoryDetailResultEntity({this.result, this.reason, this.errorCode});

	HistoryDetailResultEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<HistoryDetailResult>();
			(json['result'] as List).forEach((v) { result.add(new HistoryDetailResult.fromJson(v)); });
		}
		reason = json['reason'];
		errorCode = json['error_code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
		data['reason'] = this.reason;
		data['error_code'] = this.errorCode;
		return data;
	}
}

class HistoryDetailResult {
	String picNo;
	List<HistoryDetailResultPicurl> picUrl;
	String eId;
	String title;
	String content;

	HistoryDetailResult({this.picNo, this.picUrl, this.eId, this.title, this.content});

	HistoryDetailResult.fromJson(Map<String, dynamic> json) {
		picNo = json['picNo'];
		if (json['picUrl'] != null) {
			picUrl = new List<HistoryDetailResultPicurl>();
			(json['picUrl'] as List).forEach((v) { picUrl.add(new HistoryDetailResultPicurl.fromJson(v)); });
		}
		eId = json['e_id'];
		title = json['title'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picNo'] = this.picNo;
		if (this.picUrl != null) {
      data['picUrl'] = this.picUrl.map((v) => v.toJson()).toList();
    }
		data['e_id'] = this.eId;
		data['title'] = this.title;
		data['content'] = this.content;
		return data;
	}
}

class HistoryDetailResultPicurl {
	String picTitle;
	int id;
	String url;

	HistoryDetailResultPicurl({this.picTitle, this.id, this.url});

	HistoryDetailResultPicurl.fromJson(Map<String, dynamic> json) {
		picTitle = json['pic_title'];
		id = json['id'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pic_title'] = this.picTitle;
		data['id'] = this.id;
		data['url'] = this.url;
		return data;
	}
}
