import 'package:flutter/cupertino.dart';

enum storeKey{ customer_id, contactNumber, token, userId, id, userName,code, email,photo,phone,academic,message}
extension storeKeyString on storeKey {
  String toShortString() {
    return this.toString().split('.').last;
  }
}




