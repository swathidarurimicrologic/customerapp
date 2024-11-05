class CountriesListModel {
  CountriesListModel({required this.countriesList});
  factory CountriesListModel.fromJson(inputJson) => CountriesListModel(
        countriesList: List<CountriesModel>.from(
            inputJson.map((x) => CountriesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'countriesList':
            List<CountriesModel>.from(countriesList.map((x) => x.toJson())),
      };
  List<CountriesModel> countriesList;
}

class CountriesModel {
  CountriesModel({
    this.name,
    this.dialCode,
    this.code,
  });

  final String? name;
  final String? dialCode;
  final String? code;

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      name: json["name"],
      dialCode: json["dial_code"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() =>
      {"name": name, "dial_code": dialCode, "code": code};
}
