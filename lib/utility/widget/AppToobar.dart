import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/bloc/User_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/profile/ProfileView.dart';
import 'package:ds_book_app/app/ui/signIn/SignInView.dart';
import 'package:ds_book_app/config/Env.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


enum Header_Type {
  barlogo,
  baraction,
  barnon
}



 class AppToobar extends PreferredSize {
   Header_Type header_type;
   String Title;
   double elevation;
   final Function() onBack;

   User_Bloc user_bloc;

   AppToobar({this.header_type, this.Title,this.elevation=3,this.onBack});

   @override
   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);


  @override
  Widget build(BuildContext context) {
    user_bloc = User_Bloc(AppProvider.getApplication(context));

    if(header_type==Header_Type.barlogo){
      return HasLogo(context);
    }else if(header_type==Header_Type.baraction){
        return IconAction(context);
    }else{
      return BarNon(context);
    }

  }

  Widget HasLogo(BuildContext context){
    return AppBar(
      centerTitle: false,
      title: Text(Title,
          style: GoogleFonts.kanit(fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context))),
      leading: Container(
        padding: EdgeInsets.only(left: 10),
        child: SvgPicture.asset("assets/images/logo.svg"),
      ),
      leadingWidth: 38,
      titleSpacing: 10,
      actions: [
        _ProfileImage(context)
      ],
    );
  }

  Widget IconAction(BuildContext context){
    return AppBar(
        title: Text(Title,
            style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
        leading: GestureDetector(
            child: Icon(Icons.arrow_back), onTap: () => onBack()),
        actions: [
          _ProfileImage(context)
        ]
    );
  }
   //Navigator.pop(context)//
  Widget BarNon(BuildContext context){
    return AppBar(
      title: Text(Title,
          style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
      elevation: elevation,
      leading: GestureDetector(
          child: Icon(Icons.arrow_back), onTap: () => onBack()),
    );
  }

   _navigateToProfilePage(BuildContext context) async {
     if(await Usermanager().isLogin()){
       Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ProfileView()));

     }else{
       Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SignInView()));

     }
   }

   Widget _ProfileImage(BuildContext context){

    return InkWell(
      child: StreamBuilder(

        stream: user_bloc.getUser,
        builder: (context,snapshot){
          User user = snapshot.data;
        // print("weceewfcef");
          if(user!=null && user.imageurl!=null){
              return Container(
                margin: EdgeInsets.only(top: 11,bottom: 11,right: 10),
                width: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    width: 50,
                    placeholder: (context, url) => Lottie.asset(Env.value.loadingAnimaion,height: 30),
                    fit: BoxFit.cover,
                    imageUrl: user.imageurl,
                    errorWidget: (context, url, error) => Container(height: 30,child: Icon(Icons.error,size: 30,)),
                  ),
                ),
              );
          }else{
            return Container(
              margin: EdgeInsets.only(top: 12, bottom: 12, right: 10),
              width: 32,
              child: Padding(
                  padding: EdgeInsets.only(right: 3, left: 3),
                  child: SvgPicture.asset(
                    "assets/images/icon_profile.svg",
                    width: 5,
                    height: 5,
                  )),
              decoration: BoxDecoration(
                  color: ThemeColor.secondaryColor(context),
                  border: Border.all(
                    color: ThemeColor.secondaryColor(context),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(
                      8.0) //                 <--- border radius here
                  )),
            );
          }
        },
      ),
      onTap: (){
        _navigateToProfilePage(context);
      },
    );
   }
}
