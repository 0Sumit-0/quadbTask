class MovieResponse {
  final double score;
  final Movie show;

  MovieResponse({required this.score, required this.show});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      score: json['score']?.toDouble() ?? 0.0,
      show: Movie.fromJson(json['show']),
    );
  }
}


class Movie {
  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final String? language;
  final List<String> genres;
  final String? status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final Schedule? schedule;
  final Rating? rating;
  final int? weight;
  final Network? network;
  final WebChannel? webChannel;
  final Externals? externals;
  final Mimage? image;
  final String? summary;
  final Links? links;

  Movie({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    required this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.webChannel,
    this.externals,
    this.image,
    this.summary,
    this.links,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      language: json['language'],
      genres: List<String>.from(json['genres'] ?? []),
      status: json['status'],
      runtime: json['runtime'],
      averageRuntime: json['averageRuntime'],
      premiered: json['premiered'],
      ended: json['ended'],
      officialSite: json['officialSite'],
      schedule: json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
      weight: json['weight'] ?? 0,
      network: json['network'] != null ? Network.fromJson(json['network']) : null,
      webChannel: json['webChannel'] != null ? WebChannel.fromJson(json['webChannel']) : null,
      externals: json['externals'] != null ? Externals.fromJson(json['externals']) : null,
      image: json['image'] != null ? Mimage.fromJson(json['image']) : null,
      summary: json['summary'] ?? '',
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }
}


class Schedule {
  final String time;
  final List<String> days;

  Schedule({required this.time, required this.days});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'],
      days: List<String>.from(json['days']),
    );
  }
}

class Rating {
  final double? average;

  Rating({this.average});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average']?.toDouble(),
    );
  }
}

class Network {
  final int id;
  final String name;
  final Country country;
  final String? officialSite;

  Network({
    required this.id,
    required this.name,
    required this.country,
    this.officialSite,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      name: json['name'],
      country: Country.fromJson(json['country']),
      officialSite: json['officialSite'],
    );
  }
}

class WebChannel {
  final int id;
  final String name;
  final Country? country;

  WebChannel({required this.id, required this.name, this.country});

  factory WebChannel.fromJson(Map<String, dynamic> json) {
    return WebChannel(
      id: json['id'],
      name: json['name'],
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }
}

class Country {
  final String name;
  final String code;
  final String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
      timezone: json['timezone'],
    );
  }
}

class Externals {
  final int? tvrage;
  final int? thetvdb;
  final String? imdb;

  Externals({this.tvrage, this.thetvdb, this.imdb});

  factory Externals.fromJson(Map<String, dynamic> json) {
    return Externals(
      tvrage: json['tvrage'],
      thetvdb: json['thetvdb'],
      imdb: json['imdb'],
    );
  }
}

class Mimage {
  final String medium;
  final String original;

  Mimage({required this.medium, required this.original});

  factory Mimage.fromJson(Map<String, dynamic> json) {
    return Mimage(
      medium: json['medium'],
      original: json['original'],
    );
  }
}

class Links {
  final Link self;
  final Link? previousEpisode;
  final Link? nextEpisode;

  Links({
    required this.self,
    this.previousEpisode,
    this.nextEpisode,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: Link.fromJson(json['self']),
      previousEpisode: json['previousepisode'] != null
          ? Link.fromJson(json['previousepisode'])
          : null,
      nextEpisode: json['nextepisode'] != null
          ? Link.fromJson(json['nextepisode'])
          : null,
    );
  }
}

class Link {
  final String href;

  Link({required this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'],
    );
  }
}



class Episode {
  final int? id;
  final String? url;
  final String? name;
  final int? season;
  final int? number;
  final String? type;
  final String? airdate;
  final String? airtime;
  final String? airstamp;
  final int? runtime;
  final Rating? rating;
  final Mimage? image;
  final String? summary;
  final Links? links;

  Episode({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.type,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.rating,
    this.image,
    this.summary,
    this.links,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      season: json['season'] as int?,
      number: json['number'] as int?,
      type: json['type'] as String?,
      airdate: json['airdate'] as String?,
      airtime: json['airtime'] as String?,
      airstamp: json['airstamp'] as String?,
      runtime: json['runtime'] as int?,
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
      image: json['image'] != null ? Mimage.fromJson(json['image']) : null,
      summary: json['summary'] as String? ?? '',
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }
}

