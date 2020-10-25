
import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/ui/language/LanguageView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/RestartWidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


class SettingMobile extends StatefulWidget {
  static const String PATH = '/startup';

  @override
  _SettingMobileState createState() => _SettingMobileState();
}

class _SettingMobileState extends State<SettingMobile> with RouteAware{



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    setState(()=>{});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor(context),
      appBar: AppToobar(header_type: Header_Type.barnon,Title: LocaleKeys.setting_setting_title.tr(),onBack: (){
        Navigator.pop(context, true);
      },),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                _menuSetting(context,title: LocaleKeys.setting_language_title.tr(),countMessage: 0,icon: Icons.settings,page: LanguageView()),
                Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuSetting(BuildContext context,{String title,IconData icon,int countMessage,Widget page}){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 30,right: 20,top: 10,bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Icon(icon,color: ThemeColor.secondaryColor(context),size: 25,),
                  SizedBox(width: 5),
                  Text(title,style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context)))
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
                    color: ThemeColor.secondaryColor(context),
                    child: Text(countMessage.toString(),style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
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
        Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: page));
      },
    );
  }
}
