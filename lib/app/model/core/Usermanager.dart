

import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usermanager{

  static final String IS_LOGIN = "is_login";
  static final String USERID = "id";
  static final String FULLNAME = "fullname";
  static final String UERNAME = "username";
  static final String EMAIL = "email";
  static final String PHONE = "phone";
  static final String IMAGEURL = "imageurl";

  SharedPreferences _prefs;

  static final String USERNAME_DEMO = "ApisitKaewsansa@gmail.com";
  static final String PASSWORD_DEMO = "ZaqweR123@";

  Future<bool> isLogin() async {
     _prefs = await SharedPreferences.getInstance();

    return _prefs.getBool(IS_LOGIN) ?? false;
  }

  Future<User> getUser() async {
     _prefs = await SharedPreferences.getInstance();
    return User(id: _prefs.getString(USERID),fullname: _prefs.getString(FULLNAME),email: _prefs.getString(EMAIL),username: _prefs.getString(UERNAME),phone: _prefs.getString(PHONE),imageurl: _prefs.getString(IMAGEURL));
  }

  Future<void> Savelogin({User user}) async {
    if (user.id != "") {
       _prefs = await SharedPreferences.getInstance();
      _prefs.setString(USERID, user.id);
      _prefs.setString(FULLNAME, user.fullname);
      _prefs.setString(UERNAME, user.username);
      _prefs.setString(EMAIL, user.email);
      _prefs.setString(PHONE, user.phone);
       _prefs.setString(IMAGEURL, user.imageurl);
      _prefs.setBool(IS_LOGIN, true);

    }
    await Future<void>.delayed(Duration(seconds: 1));
  }


  Future<void> Updatelogin({String col,String val}) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(col, val);
    await Future<void>.delayed(Duration(seconds: 1));
  }


  Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(IS_LOGIN);
    _prefs.remove(USERID);
    _prefs.remove(FULLNAME);
    _prefs.remove(UERNAME);
    _prefs.remove(EMAIL);
    _prefs.remove(PHONE);
    _prefs.remove(IMAGEURL);
    _prefs.remove(IS_LOGIN);

   //return await Future<void>.delayed(Duration(seconds: 1));
  }
}