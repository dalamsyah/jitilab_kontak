import 'dart:convert';

import 'package:dio/dio.dart';

class Contact {
  String? name;
  String? avatar;
  String? gender;
  String? phone;
  String? id;
  String? email;

  Contact(this.id, this.name, this.avatar, this.gender, this.phone, this.email);

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['phone'] = phone;
    return data;
  }

}
