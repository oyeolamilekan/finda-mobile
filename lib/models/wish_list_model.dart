import 'user.dart';

class WishList {
  int? count;
  String? next;
  String? previous;
  List<WishlistResults>? results;

  WishList({this.count, this.next, this.previous, this.results});

  WishList.fromJson(json) {
    count = json['count'] as int?;
    next = json['next'] as String?;
    previous = json['previous'] as String?;
    if (json['results'] != null) {
      results = List<WishlistResults>.empty(growable: true);
      json['results'].forEach((v) {
        results!.add(WishlistResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistResults {
  String? id;
  User? user;
  String? title;
  String? slug;
  String? description;
  int? productCount;
  bool? isPrivate;
  String? created;

  WishlistResults({
    this.id,
    this.user,
    this.title,
    this.slug,
    this.description,
    this.productCount,
    this.isPrivate,
    this.created,
  });

  WishlistResults.fromJson(json) {
    id = json['id'] as String?;
    user = json['user'] != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    title = json['title'] as String?;
    slug = json['slug'] as String?;
    description = json['description'] as String?;
    productCount = json['product_count'] as int?;
    isPrivate = json['is_private'] as bool?;
    created = json['created'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['product_count'] = productCount;
    data['is_private'] = isPrivate;
    data['created'] = created;
    return data;
  }
}
