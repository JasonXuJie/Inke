class HistoryListEntity {
	List<HistoryListResult> result;
	String reason;
	int errorCode;

	HistoryListEntity({this.result, this.reason, this.errorCode});

	HistoryListEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<HistoryListResult>();
			(json['result'] as List).forEach((v) { result.add(new HistoryListResult.fromJson(v)); });
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

class HistoryListResult {
	String date;
	String eId;
	String title;
	String day;

	HistoryListResult({this.date, this.eId, this.title, this.day});

	HistoryListResult.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		eId = json['e_id'];
		title = json['title'];
		day = json['day'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['e_id'] = this.eId;
		data['title'] = this.title;
		data['day'] = this.day;
		return data;
	}
}
