import 'dart:convert';

class AliasModel {
  late final String alias;
  late final LinksModel lLinks;

  AliasModel({required this.alias, required this.lLinks});

  AliasModel.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    lLinks = json['_links'] != null
        ? LinksModel.fromJson(json['_links'])
        : LinksModel(self: '', short: '');
  }

  AliasModel.fromJsonString(String jsonString)
    : this.fromJson(
        Map<String, dynamic>.from(
          json.decode(jsonString) as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    data['_links'] = lLinks.toJson();
    return data;
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}

class LinksModel {
  late final String self;
  late final String short;

  LinksModel({required this.self, required this.short});

  LinksModel.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    short = json['short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    data['short'] = short;
    return data;
  }
}
