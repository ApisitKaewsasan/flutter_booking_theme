import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/bloc/User_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/EditProfilePage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/MyBookingPage.dart';
import 'package:ds_book_app/app/ui/page/MyReviewPage.dart';
import 'package:ds_book_app/app/ui/page/MySavedPage.dart';
import 'package:ds_book_app/app/ui/page/NotificationPage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
import 'package:ds_book_app/app/ui/page/StartUpPage.dart';
import 'package:ds_book_app/app/ui/page/VerificationPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfilePage extends StatefulWidget {

  static const String PATH = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User_Bloc user_bloc;




  @override
  Widget build(BuildContext context) {
    user_bloc = User_Bloc(AppProvider.getApplication(context));

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppToobar(header_type: Header_Type.barnon,Title: "Profile",onBack: (){
          Navigator.pop(context, true);
        },),
        body: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: user_bloc.getUser,
                    builder: (context,snapshot){
                      User user = snapshot.data;

                      return user!=null?_profile(name: user.fullname,image: user.imageurl):_profile(name: "",image: "");

                    },
                  ),
                  Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                  _menuProfile(title: "My Booking",countMessage: 1,icon: Ionicons.ios_bed,page: MyBookingPage()),
                  Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                  _menuProfile(title: "Saved",countMessage: 0,icon: Icons.bookmark,page: MySavedPage()),
                  Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                  _menuProfile(title: "Notification",countMessage: 1,icon: Icons.notifications,page: NotificationPage()),
                  Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                  _menuProfile(title: "My Review",countMessage: 1,icon: Icons.star,page: MyReviewPage()),
                  Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                  _menuProfile(title: "Log Out",countMessage: 0,icon: FontAwesome.power_off,islogout: true),
                  Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                ],
              ),
            )
          ],
        ));
  }

  Widget _profile({String name,String image}){
    return Container(
      margin: EdgeInsets.only(top: 30,left: 50,right: 50,bottom: 30),
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0) //                 <--- border radius here
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 12,
                          blurRadius: 7,
                          offset: Offset(10, 12), // changes position of shadow
                        ),
                      ]
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0) //                 <--- border radius here
                      ),
                      border: Border.all(color: Colors.grey[200]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.9),
                          spreadRadius: 10,
                          blurRadius: 12,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ]
                  ),

                  child: image!=null?ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      placeholder: (context, url) => Lottie.asset(Env.value.loadingAnimaion,height: 80),
                      fit: BoxFit.cover,
                      imageUrl: image,
                      errorWidget: (context, url, error) => Container(height: 80,width: 80,child: Icon(Icons.error,size: 30,)),
                    ),
                  ):ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      margin: EdgeInsets.only(top: 0, bottom: 0, right: 0),
                      width: 80,
                      height: 80,
                      child: Padding(
                          padding: EdgeInsets.only(right: 3, left: 3),
                          child: SvgPicture.asset(
                            "assets/images/icon_profile.svg",
                            width: 5,
                            height: 5,
                            color: Env.value.primaryColor,
                          )),
                      decoration: BoxDecoration(
                          color: Env.value.secondaryColor,
                          border: Border.all(
                            color: Env.value.secondaryColor,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(
                              8.0) //                 <--- border radius here
                          )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(name!=null?name:"Ds Booking",style: GoogleFonts.kanit(
                fontWeight: FontWeight.w400,fontSize: 18)),
            SizedBox(height: 8),
            Container(
                width: 100,
                height: 30,
                child: OutlineButton(
                  child: Text('Edit Profile',
                      style: GoogleFonts.kanit(
                          color: Env.value.secondaryColor,
                          fontWeight: FontWeight.w400,fontSize: 13)),
                  onPressed: () {
                    _navigateToEditProfilePage(context);
                  },
                  //callback when button is clicked
                  borderSide: BorderSide(
                    color: Env.value.secondaryColor, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1, //width of the border
                  ),
                  highlightedBorderColor: Env.value.secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ))
          ],
        ),
      ),
    );
  }


  Widget _menuProfile({String title,IconData icon,int countMessage,Widget page,bool islogout=false}){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 30,right: 20,top: 10,bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon,color: Env.value.secondaryColor,size: 25,),
                  SizedBox(width: 20),
                  Text(title,style: GoogleFonts.kanit(color: Colors.black))
                ],
              ),
            ),
            Row(
              children: [
                countMessage>0?ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    color: Env.value.secondaryColor,
                    child: Text(countMessage.toString(),style: GoogleFonts.kanit(color: Colors.white)),
                  ),
                ):SizedBox(),
                SizedBox(width: 8),
                Icon(Ionicons.ios_arrow_forward,size: 20,)
              ],
            )
          ],
        ),
      ),
      onTap: () async {
        if(islogout){
          logout();
        }else{
          Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: page));
        }

      },
    );
  }

  void logout(){
    Usermanager().logout().then((value){
     // _navigateToStartUpPage(context);
      Navigator.pop(context,false);
    });
  }

  _navigateToEditProfilePage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: EditProfilePage()));

  }


}
