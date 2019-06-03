class StillResultEntityEntity {
	int total;
	StillResultEntitySubject subject;
	int count;
	int start;
	List<StillResultEntityPhoto> photos;

	StillResultEntityEntity({this.total, this.subject, this.count, this.start, this.photos});

	StillResultEntityEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		subject = json['subject'] != null ? new StillResultEntitySubject.fromJson(json['subject']) : null;
		count = json['count'];
		start = json['start'];
		if (json['photos'] != null) {
			photos = new List<StillResultEntityPhoto>();
			(json['photos'] as List).forEach((v) { photos.add(new StillResultEntityPhoto.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class StillResultEntitySubject {
	StillResultEntitySubjectImages images;
	String originalTitle;
	String year;
	List<StillResultEntitySubjectDirector> directors;
	StillResultEntitySubjectRating rating;
	String alt;
	String title;
	int collectCount;
	bool hasVideo;
	List<String> pubdates;
	List<StillResultEntitySubjectCast> casts;
	String subtype;
	List<String> genres;
	List<String> durations;
	String mainlandPubdate;
	String id;

	StillResultEntitySubject({this.images, this.originalTitle, this.year, this.directors, this.rating, this.alt, this.title, this.collectCount, this.hasVideo, this.pubdates, this.casts, this.subtype, this.genres, this.durations, this.mainlandPubdate, this.id});

	StillResultEntitySubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new StillResultEntitySubjectImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		year = json['year'];
		if (json['directors'] != null) {
			directors = new List<StillResultEntitySubjectDirector>();
			(json['directors'] as List).forEach((v) { directors.add(new StillResultEntitySubjectDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new StillResultEntitySubjectRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		title = json['title'];
		collectCount = json['collect_count'];
		hasVideo = json['has_video'];
		pubdates = json['pubdates'].cast<String>();
		if (json['casts'] != null) {
			casts = new List<StillResultEntitySubjectCast>();
			(json['casts'] as List).forEach((v) { casts.add(new StillResultEntitySubjectCast.fromJson(v)); });
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

class StillResultEntitySubjectImages {
	String small;
	String large;
	String medium;

	StillResultEntitySubjectImages({this.small, this.large, this.medium});

	StillResultEntitySubjectImages.fromJson(Map<String, dynamic> json) {
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

class StillResultEntitySubjectDirector {
	String name;
	String alt;
	String id;
	StillResultEntitySubjectDirectorsAvatars avatars;
	String nameEn;

	StillResultEntitySubjectDirector({this.name, this.alt, this.id, this.avatars, this.nameEn});

	StillResultEntitySubjectDirector.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new StillResultEntitySubjectDirectorsAvatars.fromJson(json['avatars']) : null;
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

class StillResultEntitySubjectDirectorsAvatars {
	String small;
	String large;
	String medium;

	StillResultEntitySubjectDirectorsAvatars({this.small, this.large, this.medium});

	StillResultEntitySubjectDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class StillResultEntitySubjectRating {
	num average;
	int min;
	int max;
	StillResultEntitySubjectRatingDetails details;
	String stars;

	StillResultEntitySubjectRating({this.average, this.min, this.max, this.details, this.stars});

	StillResultEntitySubjectRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		details = json['details'] != null ? new StillResultEntitySubjectRatingDetails.fromJson(json['details']) : null;
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

class StillResultEntitySubjectRatingDetails {
	num one;
	num two;
	num three;
	num four;
	num five;

	StillResultEntitySubjectRatingDetails({this.one, this.two, this.three, this.four, this.five});

	StillResultEntitySubjectRatingDetails.fromJson(Map<String, dynamic> json) {
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

class StillResultEntitySubjectCast {
	String name;
	String alt;
	String id;
	StillResultEntitySubjectCastsAvatars avatars;
	String nameEn;

	StillResultEntitySubjectCast({this.name, this.alt, this.id, this.avatars, this.nameEn});

	StillResultEntitySubjectCast.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		alt = json['alt'];
		id = json['id'];
		avatars = json['avatars'] != null ? new StillResultEntitySubjectCastsAvatars.fromJson(json['avatars']) : null;
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

class StillResultEntitySubjectCastsAvatars {
	String small;
	String large;
	String medium;

	StillResultEntitySubjectCastsAvatars({this.small, this.large, this.medium});

	StillResultEntitySubjectCastsAvatars.fromJson(Map<String, dynamic> json) {
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

class StillResultEntityPhoto {
	String subjectId;
	String image;
	String nextPhoto;
	String thumb;
	StillResultEntityPhotosAuthor author;
	String icon;
	String alt;
	String createdAt;
	int recsCount;
	String prevPhoto;
	String cover;
	int commentsCount;
	String albumId;
	String id;
	int position;
	String albumUrl;
	int photosCount;
	String albumTitle;
	String desc;

	StillResultEntityPhoto({this.subjectId, this.image, this.nextPhoto, this.thumb, this.author, this.icon, this.alt, this.createdAt, this.recsCount, this.prevPhoto, this.cover, this.commentsCount, this.albumId, this.id, this.position, this.albumUrl, this.photosCount, this.albumTitle, this.desc});

	StillResultEntityPhoto.fromJson(Map<String, dynamic> json) {
		subjectId = json['subject_id'];
		image = json['image'];
		nextPhoto = json['next_photo'];
		thumb = json['thumb'];
		author = json['author'] != null ? new StillResultEntityPhotosAuthor.fromJson(json['author']) : null;
		icon = json['icon'];
		alt = json['alt'];
		createdAt = json['created_at'];
		recsCount = json['recs_count'];
		prevPhoto = json['prev_photo'];
		cover = json['cover'];
		commentsCount = json['comments_count'];
		albumId = json['album_id'];
		id = json['id'];
		position = json['position'];
		albumUrl = json['album_url'];
		photosCount = json['photos_count'];
		albumTitle = json['album_title'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['subject_id'] = this.subjectId;
		data['image'] = this.image;
		data['next_photo'] = this.nextPhoto;
		data['thumb'] = this.thumb;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		data['icon'] = this.icon;
		data['alt'] = this.alt;
		data['created_at'] = this.createdAt;
		data['recs_count'] = this.recsCount;
		data['prev_photo'] = this.prevPhoto;
		data['cover'] = this.cover;
		data['comments_count'] = this.commentsCount;
		data['album_id'] = this.albumId;
		data['id'] = this.id;
		data['position'] = this.position;
		data['album_url'] = this.albumUrl;
		data['photos_count'] = this.photosCount;
		data['album_title'] = this.albumTitle;
		data['desc'] = this.desc;
		return data;
	}
}

class StillResultEntityPhotosAuthor {
	String uid;
	String signature;
	String alt;
	String name;
	String avatar;
	String id;

	StillResultEntityPhotosAuthor({this.uid, this.signature, this.alt, this.name, this.avatar, this.id});

	StillResultEntityPhotosAuthor.fromJson(Map<String, dynamic> json) {
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
