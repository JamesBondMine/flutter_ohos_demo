class AuthModel {
  AuthModel();

  String realName = "";
  String cardImg1 = "";
  String cardImg2 = "";
  String video = "";
  String remark = "";
  String cardNum = "";

  String CreatedAt = "";
  String UpdatedAt = "";

  int id = 0;
  int userId = 0;
  int state = 0;
  String number = "";

  AuthModel.fromJson(Map data) {
    realName = data["realName"] ?? "";
    cardImg1 = data["cardImg1"] ?? "";
    cardImg2 = data["cardImg2"] ?? "";
    video = data["video"] ?? "";
    remark = data["remark"] ?? "";
    cardNum = data["cardNum"] ?? "";

    CreatedAt = data["CreatedAt"] ?? "";
    UpdatedAt = data["UpdatedAt"] ?? "";

    id = data["ID"] ?? 0;
    userId = data["userId"] ?? 0;
    state = data["state"] ?? 0;
    number = data["number"] ?? "";
  }
}
