// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel? loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel? data) => json.encode(data!.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.code,
    this.data,
  });

  String? status;
  String? code;
  Data? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.token,
    this.id,
    this.uuid,
    this.code,
    this.email,
    this.username,
    this.phone,
    this.photo,
    this.tokenType,
    this.message,
    this.expiresAt,
    this.academicId,
    this.settings,
  });

  String? token;
  int? id;
  String? uuid;
  String? code;
  dynamic email;
  String? username;
  String? phone;
  String? photo;
  String? tokenType;
  String? message;
  DateTime? expiresAt;
  int? academicId;
  Settings? settings;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    id: json["id"],
    uuid: json["uuid"],
    code: json["code"],
    email: json["email"],
    username: json["username"],
    phone: json["phone"],
    photo: json["photo"],
    tokenType: json["token_type"],
    message: json["message"],
    expiresAt: DateTime.parse(json["expires_at"]),
    academicId: json["academic_id"],
    settings: Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "uuid": uuid,
    "code": code,
    "email": email,
    "username": username,
    "phone": phone,
    "photo": photo,
    "token_type": tokenType,
    "message": message,
    "expires_at": expiresAt?.toIso8601String(),
    "academic_id": academicId,
    "settings": settings!.toJson(),
  };
}

class Settings {
  Settings({
    this.staffHomeworkApprovalType,
    this.classTeacherHomeworkApprovalType,
    this.staffClassTestApprovalType,
    this.classClassTestApprovalType,
    this.payrollMenuType,
  });

  int? staffHomeworkApprovalType;
  int? classTeacherHomeworkApprovalType;
  int? staffClassTestApprovalType;
  int? classClassTestApprovalType;
  int? payrollMenuType;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    staffHomeworkApprovalType: json["staff_homework_approval_type"],
    classTeacherHomeworkApprovalType: json["class_teacher_homework_approval_type"],
    staffClassTestApprovalType: json["staff_class_test_approval_type"],
    classClassTestApprovalType: json["class_class_test_approval_type"],
    payrollMenuType: json["payroll_menu_type"],
  );

  Map<String, dynamic> toJson() => {
    "staff_homework_approval_type": staffHomeworkApprovalType,
    "class_teacher_homework_approval_type": classTeacherHomeworkApprovalType,
    "staff_class_test_approval_type": staffClassTestApprovalType,
    "class_class_test_approval_type": classClassTestApprovalType,
    "payroll_menu_type": payrollMenuType,
  };
}
