// class FirebaseAuthModel {
//   late String name;
//   String? email;
//   String? password;
//
//
//
//   FirebaseAuthModel(this.name,this.email,this.password);
// }

class FirebaseAuthModel {
   String? name;
  String? email;
  String? password;

  FirebaseAuthModel(this.name,this.email,this.password);

  factory FirebaseAuthModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new FirebaseAuthModel(
        parsedJson['name'] ?? "",
         parsedJson['email'] ?? "",
        parsedJson['password'] ?? "");
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,

    };
  }
}