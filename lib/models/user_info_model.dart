class UserInformationModel {
  UserInformationModel(
      {this.name,
      this.lastName,
      this.contact,
      this.email,
      this.isEmailSubscribed,
      this.isTextSubscribed,
      this.token});
  String? name;
  String? lastName;
  String? contact;
  String? email;
  bool? isEmailSubscribed;
  bool? isTextSubscribed;
  String? token;

  factory UserInformationModel.fromJson(Map<String, dynamic> json) =>
      UserInformationModel(
          name: json["name"] ?? '',
          lastName: json["last_name"] ?? '',
          contact: json["contact"] ?? '',
          email: json["email"] ?? '',
          isEmailSubscribed: json["is_email_subscribed"] ?? '',
          isTextSubscribed: json["is_text_subscribed"] ?? '',
          token: json["token"]);
  Map<String, dynamic> toJson() => {
        "name": name,
        "last_name": lastName,
        "contact": contact,
        "email": email,
        "is_email_subscribed": isEmailSubscribed,
        "is_text_subscribed": isTextSubscribed,
        "token": token
      };
}
