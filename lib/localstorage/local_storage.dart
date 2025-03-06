import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String _todokey = 'todo';
  final String _isLoggedIn = 'loginKey';

  Future<void> setIsLoggedin(bool stat) async {
    await _storage.write(key: _isLoggedIn, value: stat.toString());
    return;
  }
  
  Future<bool> getIsLoggedin() async {
    String? val = await _storage.read(key: _isLoggedIn);
    return val == "true" ? true : false;
  }
  // Future<void>updateStatus()async{
  //   await 
  // }
  Future<void> setTodo(List<Map<String, dynamic>> todo) async {
    if(todo==[]) {
      await _storage.write(key:_todokey, value: '');
      }
    else{    
      await _storage.write(key: _todokey, value: jsonEncode(todo));
    }
  }

  Future<List<Map<String, dynamic>>> getTodo() async {
    String? data = await _storage.read(key: _todokey);
    if (data == null || data.isEmpty) {
      return []; // Return an empty list if no data is found
    }
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    } catch (e) {
      return []; // Return an empty list in case of error
    }
  }
}
