class MovieDetailResultEntity {
	String year;
	dynamic currentSeason;
	List<MovieDetailResultDirector> directors;
	MovieDetailResultRating rating;
	String doubanSite;
	String mobileUrl;
	String title;
	String scheduleUrl;
	String subtype;
	List<String> genres;
	dynamic doCount;
	String id;
	int ratingsCount;
	int wishCount;
	String summary;
	MovieDetailResultImages images;
	String originalTitle;
	String alt;
	List<String> countries;
	dynamic episodesCount;
	int collectCount;
	List<MovieDetailResultCast> casts;
	dynamic seasonsCount;
	String shareUrl;
	int commentsCount;
	List<String> aka;
	int reviewsCount;

	MovieDetailResultEntity({this.year, this.currentSeason, this.directors, this.rating, this.doubanSite, this.mobileUrl, this.title, this.scheduleUrl, this.subtype, this.genres, this.doCount, this.id, this.ratingsCount, this.wishCount, this.summary, this.images, this.originalTitle, this.alt, this.countries, this.episodesCount, this.collectCount, this.casts, this.seasonsCount, this.shareUrl, this.commentsCount, this.aka, this.reviewsCount});

	MovieDetailResultEntity.fromJson(Map<String, dynamic> json) {
		year = json['year'];
		currentSeason = json['current_season'];
		if (json['directors'] != null) {
			directors = new List<MovieDetailResultDirector>();
			(json['directors'] as List).forEach((v) { directors.add(new MovieDetailResultDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new MovieDetailResultRating.fromJson(json['rating']) : null;
		doubanSite = json['douban_site'];
		mobileUrl = json['mobile_url'];
		title = json['title'];
		scheduleUrl = json['schedule_url'];
		subtype = json['subtype'];
		genres = json['genres'].cast<String>();
		doCount = json['do_count'];
		id = json['id'];
		ratingsCount = json['ratings_count'];
		wishCount = json['wish_count'];
		summary = json['summary'];
		images = json['images'] != null ? new MovieDetailResultImages.fromJson(json['images']) : null;
		originalTitle = json['original_title'];
		alt = json['alt'];
		countries = json['countries'].cast<String>();
		episodesCount = json['episodes_count'];
		collectCount = json['collect_count'];
		if (json['casts'] != null) {
			casts = new List<MovieDetailResultCast>();
			(json['casts'] as List).forEach((v) { casts.add(new MovieDetailResultCast.fromJson(v)); });
		}
		seasonsCount = json['seasons_count'];
		shareUrl = json['share_url'];
		commentsCount = json['comments_count'];
		aka = json['aka'].cast<String>();
		reviewsCount = json['reviews_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['year'] = this.year;
		data['current_season'] = this.currentSeason;
		if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['douban_site'] = this.doubanSite;
		data['mobile_url'] = this.mobileUrl;
		data['title'] = this.title;
		data['schedule_url'] = this.scheduleUrl;
		data['subtype'] = this.subtype;
		data['genres'] = this.genres;
		data['do_count'] = this.doCount;
		data['id'] = this.id;
		data['ratings_count'] = this.ratingsCount;
		data['wish_count'] = this.wishCount;
		data['summary'] = this.summary;
		if (this.images != null) {
      data['images'] = this.images.toJson();
    }
		data['original_title'] = this.originalTitle;
		data['alt'] = this.alt;
		data['countries'] = this.countries;
		data['episodes_count'] = this.episodesCount;
		data['collect_count'] = this.collectCount;
		if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
		data['seasons_count'] = this.seasonsCount;
		data['share_url'] = this.shareUrl;
		data['comments_count'] = this.commentsCount;
		data['aka'] = this.aka;
		data['reviews_count'] = this.reviewsCount;
		return data;
	}
}

class MovieDetailResultDirector {
	String alt;
	String name;
	String id;
	MovieDetailResultDirectorsAvatars avatars;

	MovieDetailResultDirector({this.alt, this.name, this.id, this.avatars});

	MovieDetailResultDirector.fromJson(Map<String, dynamic> json) {
		alt = json['alt'];
		name = json['name'];
		id = json['id'];
		avatars = json['avatars'] != null ? new MovieDetailResultDirectorsAvatars.fromJson(json['avatars']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['alt'] = this.alt;
		data['name'] = this.name;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		return data;
	}
}

class MovieDetailResultDirectorsAvatars {
	String small;
	String large;
	String medium;

	MovieDetailResultDirectorsAvatars({this.small, this.large, this.medium});

	MovieDetailResultDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class MovieDetailResultRating {
	double average;
	int min;
	int max;
	String stars;

	MovieDetailResultRating({this.average, this.min, this.max, this.stars});

	MovieDetailResultRating.fromJson(Map<String, dynamic> json) {
		average = json['average'];
		min = json['min'];
		max = json['max'];
		stars = json['stars'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['average'] = this.average;
		data['min'] = this.min;
		data['max'] = this.max;
		data['stars'] = this.stars;
		return data;
	}
}

class MovieDetailResultImages {
	String small;
	String large;
	String medium;

	MovieDetailResultImages({this.small, this.large, this.medium});

	MovieDetailResultImages.fromJson(Map<String, dynamic> json) {
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

class MovieDetailResultCast {
	String alt;
	String name;
	String id;
	MovieDetailResultCastsAvatars avatars;

	MovieDetailResultCast({this.alt, this.name, this.id, this.avatars});

	MovieDetailResultCast.fromJson(Map<String, dynamic> json) {
		alt = json['alt'];
		name = json['name'];
		id = json['id'];
		avatars = json['avatars'] != null ? new MovieDetailResultCastsAvatars.fromJson(json['avatars']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['alt'] = this.alt;
		data['name'] = this.name;
		data['id'] = this.id;
		if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
		return data;
	}
}

class MovieDetailResultCastsAvatars {
	String small;
	String large;
	String medium;

	MovieDetailResultCastsAvatars({this.small, this.large, this.medium});

	MovieDetailResultCastsAvatars.fromJson(Map<String, dynamic> json) {
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
