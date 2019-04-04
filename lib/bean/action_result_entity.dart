class ActionResultEntity {
	int total;
	int count;
	int start;
	List<ActionResultDistrict> districts;
	List<ActionResultEvent> events;

	ActionResultEntity({this.total, this.count, this.start, this.districts, this.events});

	ActionResultEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		count = json['count'];
		start = json['start'];
		if (json['districts'] != null) {
			districts = new List<ActionResultDistrict>();
			(json['districts'] as List).forEach((v) { districts.add(new ActionResultDistrict.fromJson(v)); });
		}
		if (json['events'] != null) {
			events = new List<ActionResultEvent>();
			(json['events'] as List).forEach((v) { events.add(new ActionResultEvent.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['count'] = this.count;
		data['start'] = this.start;
		if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
		if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ActionResultDistrict {
	String name;
	String id;

	ActionResultDistrict({this.name, this.id});

	ActionResultDistrict.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class ActionResultEvent {
	String imageHlarge;
	String categoryName;
	String priceRange;
	String subcategoryName;
	String title;
	String timeStr;
	String content;
	String geo;
	bool hasTicket;
	String locName;
	String id;
	String adaptUrl;
	ActionResultEventsOwner owner;
	String canInvite;
	String image;
	String address;
	String album;
	String alt;
	int wisherCount;
	String endTime;
	String beginTime;
	String feeStr;
	dynamic label;
	String locId;
	String uri;
	String url;
	String tags;
	int participantCount;
	String imageLmobile;
	String category;

	ActionResultEvent({this.imageHlarge, this.categoryName, this.priceRange, this.subcategoryName, this.title, this.timeStr, this.content, this.geo, this.hasTicket, this.locName, this.id, this.adaptUrl, this.owner, this.canInvite, this.image, this.address, this.album, this.alt, this.wisherCount, this.endTime, this.beginTime, this.feeStr, this.label, this.locId, this.uri, this.url, this.tags, this.participantCount, this.imageLmobile, this.category});

	ActionResultEvent.fromJson(Map<String, dynamic> json) {
		imageHlarge = json['image_hlarge'];
		categoryName = json['category_name'];
		priceRange = json['price_range'];
		subcategoryName = json['subcategory_name'];
		title = json['title'];
		timeStr = json['time_str'];
		content = json['content'];
		geo = json['geo'];
		hasTicket = json['has_ticket'];
		locName = json['loc_name'];
		id = json['id'];
		adaptUrl = json['adapt_url'];
		owner = json['owner'] != null ? new ActionResultEventsOwner.fromJson(json['owner']) : null;
		canInvite = json['can_invite'];
		image = json['image'];
		address = json['address'];
		album = json['album'];
		alt = json['alt'];
		wisherCount = json['wisher_count'];
		endTime = json['end_time'];
		beginTime = json['begin_time'];
		feeStr = json['fee_str'];
		label = json['label'];
		locId = json['loc_id'];
		uri = json['uri'];
		url = json['url'];
		tags = json['tags'];
		participantCount = json['participant_count'];
		imageLmobile = json['image_lmobile'];
		category = json['category'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image_hlarge'] = this.imageHlarge;
		data['category_name'] = this.categoryName;
		data['price_range'] = this.priceRange;
		data['subcategory_name'] = this.subcategoryName;
		data['title'] = this.title;
		data['time_str'] = this.timeStr;
		data['content'] = this.content;
		data['geo'] = this.geo;
		data['has_ticket'] = this.hasTicket;
		data['loc_name'] = this.locName;
		data['id'] = this.id;
		data['adapt_url'] = this.adaptUrl;
		if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
		data['can_invite'] = this.canInvite;
		data['image'] = this.image;
		data['address'] = this.address;
		data['album'] = this.album;
		data['alt'] = this.alt;
		data['wisher_count'] = this.wisherCount;
		data['end_time'] = this.endTime;
		data['begin_time'] = this.beginTime;
		data['fee_str'] = this.feeStr;
		data['label'] = this.label;
		data['loc_id'] = this.locId;
		data['uri'] = this.uri;
		data['url'] = this.url;
		data['tags'] = this.tags;
		data['participant_count'] = this.participantCount;
		data['image_lmobile'] = this.imageLmobile;
		data['category'] = this.category;
		return data;
	}
}

class ActionResultEventsOwner {
	String uid;
	String largeAvatar;
	String name;
	String alt;
	String avatar;
	String id;
	String type;
	bool isBanned;
	bool isSuicide;

	ActionResultEventsOwner({this.uid, this.largeAvatar, this.name, this.alt, this.avatar, this.id, this.type, this.isBanned, this.isSuicide});

	ActionResultEventsOwner.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		largeAvatar = json['large_avatar'];
		name = json['name'];
		alt = json['alt'];
		avatar = json['avatar'];
		id = json['id'];
		type = json['type'];
		isBanned = json['is_banned'];
		isSuicide = json['is_suicide'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['large_avatar'] = this.largeAvatar;
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['avatar'] = this.avatar;
		data['id'] = this.id;
		data['type'] = this.type;
		data['is_banned'] = this.isBanned;
		data['is_suicide'] = this.isSuicide;
		return data;
	}
}
