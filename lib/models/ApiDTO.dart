class ApiDTO {

  String id;
  String kind;
  String name;
  String version;
  String title;
  String description;
  String discoveryRestUrl;
  String documentationLink;
  bool preferred;
  bool isFavorited = false;

  ApiDTO(this.id, this.kind, this.name, this.version, this.title,
      this.description, this.discoveryRestUrl, this.documentationLink,
      this.preferred);

  ApiDTO.fromMap(Map json)
      : id = json['id'],
        kind = json['kind'],
        name = json['name'],
        version = json['version'],
        title = json['title'],
        description = json['description'],
        discoveryRestUrl = json['discoveryRestUrl'],
        documentationLink = json['documentationLink'],
        preferred = json['preferred'] == 1;

}