class WatchListModel {
  final String id;
  final String name;
  final String contacts;
  String? url;

  WatchListModel(
      {required this.id, required this.name, required this.contacts, this.url});

  factory WatchListModel.fromJson(Map<String, dynamic> json) {
    return WatchListModel(
        id: json['id'],
        name: json['name'],
        contacts: json['Contacts'],
        url: json['url']);
  }
}
