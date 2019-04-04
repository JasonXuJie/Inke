class MovieListEntity {
	int total;
	List<MovieListSubject> subjects;
	int count;
	int start;
	String title;

	MovieListEntity({this.total, this.subjects, this.count, this.start, this.title});

	MovieListEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['subjects'] != null) {
			subjects = new List<MovieListSubject>();
			(json['subjects'] as List).forEach((v) { subjects.add(new MovieListSubject.fromJson(v)); });
		}
		count = json['count'];
		start = json['start'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
		data['count'] = this.count;
		data['start'] = this.start;
		data['title'] = this.title;
		return data;
	}
}

class MovieListSubject {
	MovieListSubjectsImages images;
	List<MovieListSubjectsCast> casts;
	String originalTitle;
	String subtype;
	String year;
	List<String> genres;
	List<MovieListSubjectsDirector> directors;
	MovieListSubjectsRating rating;
	String alt;
	String id;
	String title;
	int collectCount;

	MovieListSubject({this.images, this.casts, this.originalTitle, this.subtype, this.year, this.genres, this.directors, this.rating, this.alt, this.id, this.title, this.collectCount});

	MovieListSubject.fromJson(Map<String, dynamic> json) {
		images = json['images'] != null ? new MovieListSubjectsImages.fromJson(json['images']) : null;
		if (json['casts'] != null) {
			casts = new List<MovieListSubjectsCast>();
			(json['casts'] as List).forEach((v) { casts.add(new MovieListSubjectsCast.fromJson(v)); });
		}
		originalTitle = json['original_title'];
		subtype = json['subtype'];
		year = json['year'];
		genres = json['genres'].cast<String>();
		if (json['directors'] != null) {
			directors = new List<MovieListSubjectsDirector>();
			(json['directors'] as List).forEach((v) { directors.add(new MovieListSubjectsDirector.fromJson(v)); });
		}
		rating = json['rating'] != null ? new MovieListSubjectsRating.fromJson(json['rating']) : null;
		alt = json['alt'];
		id = json['id'];
		title = json['title'];
		collectCount = json['collect_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.images != null) {
      data['images'] = this.images.toJson();
    }
		if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
		data['original_title'] = this.originalTitle;
		data['subtype'] = this.subtype;
		data['year'] = this.year;
		data['genres'] = this.genres;
		if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['alt'] = this.alt;
		data['id'] = this.id;
		data['title'] = this.title;
		data['collect_count'] = this.collectCount;
		return data;
	}
}

class MovieListSubjectsImages {
	String small;
	String large;
	String medium;

	MovieListSubjectsImages({this.small, this.large, this.medium});

	MovieListSubjectsImages.fromJson(Map<String, dynamic> json) {
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

class MovieListSubjectsCast {
	String alt;
	String name;
	String id;
	MovieListSubjectsCastsAvatars avatars;

	MovieListSubjectsCast({this.alt, this.name, this.id, this.avatars});

	MovieListSubjectsCast.fromJson(Map<String, dynamic> json) {
		alt = json['alt'];
		name = json['name'];
		id = json['id'];
		avatars = json['avatars'] != null ? new MovieListSubjectsCastsAvatars.fromJson(json['avatars']) : null;
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

class MovieListSubjectsCastsAvatars {
	String small;
	String large;
	String medium;

	MovieListSubjectsCastsAvatars({this.small, this.large, this.medium});

	MovieListSubjectsCastsAvatars.fromJson(Map<String, dynamic> json) {
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

class MovieListSubjectsDirector {
	String alt;
	String name;
	String id;
	MovieListSubjectsDirectorsAvatars avatars;

	MovieListSubjectsDirector({this.alt, this.name, this.id, this.avatars});

	MovieListSubjectsDirector.fromJson(Map<String, dynamic> json) {
		alt = json['alt'];
		name = json['name'];
		id = json['id'];
		avatars = json['avatars'] != null ? new MovieListSubjectsDirectorsAvatars.fromJson(json['avatars']) : null;
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

class MovieListSubjectsDirectorsAvatars {
	String small;
	String large;
	String medium;

	MovieListSubjectsDirectorsAvatars({this.small, this.large, this.medium});

	MovieListSubjectsDirectorsAvatars.fromJson(Map<String, dynamic> json) {
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

class MovieListSubjectsRating {
	double average;
	int min;
	int max;
	String stars;

	MovieListSubjectsRating({this.average, this.min, this.max, this.stars});

	MovieListSubjectsRating.fromJson(Map<String, dynamic> json) {
		average = (json['average'] as num).toDouble();
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
