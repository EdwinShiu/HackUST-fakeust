class AreaList {
  final List<Area> areas;

  AreaList({
    this.areas,
  });

  factory AreaList.fromJson(List<dynamic> parsedJson) {
    List<Area> areas = new List<Area>();
    areas = parsedJson.map((i) => Area.fromJson(i)).toList();

    return new AreaList(
      areas: areas,
    );
  }
}

class Area {
  final String location;
  final List latlng;

  Area({
    this.location,
    this.latlng,
  });

  factory Area.fromJson(Map<String, dynamic> parsedJson) {
    return new Area(
      location: parsedJson['location'],
      latlng: parsedJson['latlng'],
    );
  }
}
