import 'user.dart';

class Notifications {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  Notifications({this.count, this.next, this.previous, this.results});

  Notifications.fromJson(json) {
    count = json['count'] as int?;
    next = json['next'] as String?;
    previous = json['previous'] as String?;
    if (json['results'] != null) {
      results = List<Results>.empty(growable: true);
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
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

class Results {
  String? id;
  User? userTo;
  User? userFrom;
  String? title;
  String? verb;
  bool? isRead;
  String? appAction;
  String? created;
  String? app;

  Results(
      {this.id,
      this.userTo,
      this.userFrom,
      this.title,
      this.verb,
      this.isRead,
      this.appAction,
      this.created,
      this.app});

  Results.fromJson(json) {
    id = json['id'] as String?;
    userTo = json['user_to'] != null
        ? User.fromJson(json['user_to'] as Map<String, dynamic>)
        : null;
    userFrom = json['user_from'] != null
        ? User.fromJson(json['user_from'] as Map<String, dynamic>)
        : null;
    title = json['title'] as String?;
    verb = json['verb'] as String?;
    isRead = json['is_read'] as bool?;
    appAction = json['app_action'] as String?;
    created = json['created'] as String?;
    app = json['app'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (userTo != null) {
      data['user_to'] = userTo!.toJson();
    }
    if (userFrom != null) {
      data['user_from'] = userFrom!.toJson();
    }
    data['title'] = title;
    data['verb'] = verb;
    data['is_read'] = isRead;
    data['app_action'] = appAction;
    data['created'] = created;
    data['app'] = app;
    return data;
  }
}
