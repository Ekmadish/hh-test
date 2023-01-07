class NotificationModel {
  NotificationModel({
    this.data,
    this.links,
    this.meta,
  });

  NotificationModel copyWith({List<Datum?>? data, Links? links, Meta? meta}) {
    if (data != null) data = this.data! + data;
    return NotificationModel(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }

  List<Datum?>? data;
  Links? links;
  Meta? meta;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        data: json["data"] == null
            ? []
            : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.isRead,
    this.notifiedAt,
  });

  int? id;
  String? title;
  String? description;
  String? imageUrl;
  bool? isRead;
  DateTime? notifiedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        isRead: json["is_read"],
        notifiedAt: DateTime.parse(json["notified_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image_url": imageUrl,
        "is_read": isRead,
        "notified_at": notifiedAt?.toIso8601String(),
      };
}

class Links {
  Links({this.first, this.last, this.prev, this.next});

  String? first;
  String? last;
  dynamic prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link?>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link?>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x!.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
