class UserModel {
  String email;
  String uid;
  String username;
  DateTime createdAt;
  
  UserModel({this.email, this.uid, this.username, this.createdAt});
  
  Map setUser(UserModel user) {
    var data = Map<String, dynamic>();
  
    data["uid"] = user.uid;
    data["username"] = user.username;
    data["email"] = user.email;
    data["createdAt"] = user.createdAt;
  
    return data;
  }
  
  UserModel.getUser(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.username = mapData["username"];
    this.email = mapData["email"];
  }
}