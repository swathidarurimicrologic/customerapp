class SearchLocationListModel {
  SearchLocationListModel({required this.searchLocationList});
  factory SearchLocationListModel.fromJson(inputJson) =>
      SearchLocationListModel(
        searchLocationList: List<SearchLocationModel>.from(
            inputJson.map((x) => SearchLocationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'searchLocationList': List<SearchLocationModel>.from(
            searchLocationList.map((x) => x.toJson())),
      };
  List<SearchLocationModel> searchLocationList;
}

class SearchLocationModel {
  String name;
  String abbreviation;
  List<LocationDetail> locationDetails;

  SearchLocationModel({
    required this.name,
    required this.abbreviation,
    required this.locationDetails,
  });

  factory SearchLocationModel.fromJson(Map<String, dynamic> json) =>
      SearchLocationModel(
        name: json["name"],
        abbreviation: json["abbreviation"],
        locationDetails: List<LocationDetail>.from(
            json["location_details"].map((x) => LocationDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "abbreviation": abbreviation,
        "location_details":
            List<dynamic>.from(locationDetails.map((x) => x.toJson())),
      };
}

class LocationDetail {
  String locationName;
  String distance;
  String address;
  bool isFavorite;

  LocationDetail(
      {required this.locationName,
      required this.distance,
      required this.address,
      required this.isFavorite});

  factory LocationDetail.fromJson(Map<String, dynamic> json) => LocationDetail(
      locationName: json["location_name"],
      distance: json["distance"],
      address: json["address"],
      isFavorite: json["is_favorite"]);

  Map<String, dynamic> toJson() => {
        "location_name": locationName,
        "distance": distance,
        "address": address,
        "is_favorite": isFavorite
      };
}
