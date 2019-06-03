class CommentResultEntity {
	int total;
	List<CommantResultCommants> comments;
	int nextStart;
	CommentResultSubject subject;
	int count;
	int start;

	CommentResultEntity({this.total, this.comments, this.nextStart, this.subject, this.count, this.start});

	CommentResultEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['comments'] != null) {
			comments = new List<CommantResultCommants>();
			(json['comments'] as List).forEach((v) { comments.add(new CommantResultCommants.fromJson(v)); });
		}
		nextStart = json['next_start'];
		subject = json['subject'] != null ? new CommentResultSubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
		data['next_start'] = this.nextStart;
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		return data;
	}
}

class CommantResultCommants {
	String subjectId;
	CommentResultCommentsAuthor author;
	CommentResultCommentsRating rating;
	String createdAt;
	String id;
	int usefulCount;
	String content;

	CommantResultCommants({this.subjectId, this.author, this.rating, this.createdAt, this.id, this.usefulCount, this.content});

	CommantResultCommants.fromJson(Map<String, dynamic> json) {
		subjectId = json['subject_id'];
		author = json['author'] != null ? new CommentResultCommentsAuthor.fromJson(json['author']) : null;
		rating = json['rating'] != null ? new CommentResultCommentsRating.fromJson(json['rating']) : null;
		createdAt = json['created_at'];
		id = json['id'];
		usefulCount = json['useful_count'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['subject_id'] = this.subjectId;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['created_at'] = this.createdAt;
		data['id'] = this.id;
		data['useful_count'] = this.usefulCount;
		data['content'] = this.content;
		return data;
	}
}

class CommentResultCommentsAuthor {
	String uid;
	String signature;
	String alt;
	String name;
	String avatar;
	String id;

	CommentResultCommentsAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	CommentResultCommentsAuthor.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		signature = json['signature'];
		alt = json['alt'];
		name = json['name'];
		avatar = json['avatar'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['signature'] = this.signature;
		data['alt'] = this.alt;
		data['name'] = this.name;
		data['avatar'] = this.avatar;
		data['id'] = this.id;
		return data;
	}
}

class CommentResultCommentsRating {
	int min;
	int max;
	num value;

	CommentResultCommentsRating({this.min, this.max, this.value});

	CommentResultCommentsRating.fromJson(Map<String, dynamic> json) {
		min = json['min'];
		max = json['max'];
		value = json['value'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['min'] = this.min;
		data['max'] = this.max;
		data['value'] = this.value;
		return data;
	}
}

class CommentResultSubject {
	CommentResultSubjectImages images;
	String originalTitle;
	String year;
	List<CommantResultSubjectDirectors> directors;
	CommentResultSubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<CommantResultSubjectCasts> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	CommentResultSubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	CommentResultSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new CommentResultSubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<CommantResultSubjectDirectors>();
			(json['directors'] as List).forEach((v) { directors.add(new CommantResultSubjectDirectors.fromJson(v)); });
		}
		rating = json['rating'] != null ? new CommentResultSubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = new List<CommantResultSubjectCasts>();
			(json['casts'] as List).forEach((v) { casts.add(new CommantResultSubjectCasts.fromJson(v)); });
		}
		subtype = json['subtype'];
		genres = json['genres'].cast<String>();
		durations = json['durations'].cast<String>();
		mainlandPubdate = json['mainland_pubdate'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.images != null) {
      data['images'] = this.images.toJson();
    }
		data['original_title'] = this.originalTitle;
		data['year'] = this.year;
		if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['alt'] = this.alt;
		data['title'] = this.title;
		data['collect_count'] = this.collectCount;
		data['has_video'] = this.hasVideo;
		data['pubdates'] = this.pubdates;
		if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
		data['subtype'] = this.subtype;
		data['genres'] = this.genres;
		data['durations'] = this.durations;
		data['mainland_pubdate'] = this.mainlandPubdate;
		data['id'] = this.id;
		return data;
	}
}

class CommentResultSubjectImages {
	String small;
	String large;
	String medium;

	CommentResultSubjectImages({this.small, this.large, this.medium});

	CommentResultSubjectImages.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}

class CommantResultSubjectDirectors {
	String name;
	String alt;
	String id;
	CommentResultSubjectDirectorsAvatars avatars;
	String nameEn;

	CommantResultSubjectDirectors({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CommantResultSubjectDirectors.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CommentResultSubjectDirectorsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class CommentResultSubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	CommentResultSubjectDirectorsAvatars({this.small, this.large, this.medium});

	CommentResultSubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}

class CommentResultSubjectRating {
	num average;
	int min;
	int max;
	CommentResultSubjectRatingDetails details;
	String stars;

	CommentResultSubjectRating({this.average, this.min, this.max, this.details, this.stars});

	CommentResultSubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? new CommentResultSubjectRatingDetails.fromJson(json['details']) : null;
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['average'] = this.average;
		data['min'] = this.min;
		data['max'] = this.max;
		if (this.details != null) {
      data['details'] = this.details.toJson();
    }
		data['stars'] = this.stars;
		return data;
	}
}

class CommentResultSubjectRatingDetails {
	num one;
	num two;
	num three;
	num four;
	num five;

	CommentResultSubjectRatingDetails({this.one, this.two, this.three, this.four, this.five});

	CommentResultSubjectRatingDetails.fromJson(Map<String, dynamic> json) {
		one = json['1'];
		two = json['2'];
		three = json['3'];
		four = json['4'];
		five = json['5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['1'] = this.one;
		data['2'] = this.two;
		data['3'] = this.three;
		data['4'] = this.four;
		data['5'] = this.five;
		return data;
	}
}

class CommantResultSubjectCasts {
	String name;
	String alt;
	String id;
	CommentResultSubjectCastsAvatars avatars;
	String nameEn;

	CommantResultSubjectCasts({this.name, this.alt, this.id, this.avatars, this.nameEn});

	CommantResultSubjectCasts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new CommentResultSubjectCastsAvatars.fromJson(json['avatars']) : null;
		nameEn = json['name_en'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['alt'] = this.alt;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		data['name_en'] = this.nameEn;
		return data;
	}
}

class CommentResultSubjectCastsAvatars {
	String small;
	String large;
	String medium;

	CommentResultSubjectCastsAvatars({this.small, this.large, this.medium});

	CommentResultSubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
		small = json['small'];
		large = json['large'];
		medium = json['medium'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = this.small;
		data['large'] = this.large;
		data['medium'] = this.medium;
		return data;
	}
}
