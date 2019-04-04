class PairingResultEntity {
	PairingResult result;
	String reason;
	int errorCode;

	PairingResultEntity({this.result, this.reason, this.errorCode});

	PairingResultEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new PairingResult.fromJson(json['result']) : null;
		reason = json['reason'];
		errorCode = json['error_code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] = this.result.toJson();
    }
		data['reason'] = this.reason;
		data['error_code'] = this.errorCode;
		return data;
	}
}

class PairingResult {
	String xingzuo1;
	String content2;
	String content1;
	String title;
	String xingzuo2;

	PairingResult({this.xingzuo1, this.content2, this.content1, this.title, this.xingzuo2});

	PairingResult.fromJson(Map<String, dynamic> json) {
		xingzuo1 = json['xingzuo1'];
		content2 = json['content2'];
		content1 = json['content1'];
		title = json['title'];
		xingzuo2 = json['xingzuo2'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['xingzuo1'] = this.xingzuo1;
		data['content2'] = this.content2;
		data['content1'] = this.content1;
		data['title'] = this.title;
		data['xingzuo2'] = this.xingzuo2;
		return data;
	}
}
