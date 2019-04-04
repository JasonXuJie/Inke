class CityResultEntity {
	List<CityResultLoc> locs;
	int total;
	int count;
	int start;

	CityResultEntity({this.locs, this.total, this.count, this.start});

	CityResultEntity.fromJson(Map<String, dynamic> json) {
		if (json['locs'] != null) {
			locs = new List<CityResultLoc>();
			(json['locs'] as List).forEach((v) { locs.add(new CityResultLoc.fromJson(v)); });
		}
		total = json['total'];
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.locs != null) {
      data['locs'] = this.locs.map((v) => v.toJson()).toList();
    }
		data['total'] = this.total;
		data['count'] = this.count;
		data['start'] = this.start;
		return data;
	}
}

class CityResultLoc {
	String habitable;
	String parent;
	String uid;
	String name;
	String id;

	CityResultLoc({this.habitable, this.parent, this.uid, this.name, this.id});

	CityResultLoc.fromJson(Map<String, dynamic> json) {
		habitable = json['habitable'];
		parent = json['parent'];
		uid = json['uid'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['habitable'] = this.habitable;
		data['parent'] = this.parent;
		data['uid'] = this.uid;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
