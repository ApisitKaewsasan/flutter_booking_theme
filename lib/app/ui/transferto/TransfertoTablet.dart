import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class TransfertoTablet extends StatelessWidget {

  static const String PATH = '/transferto';

  final title_val;


  const TransfertoTablet({Key key, this.title_val}) : super(key: key);


  static String generatePath(String title_val){
    Map<String, dynamic> parma = {
      'title_val': title_val
    };
    Uri uri = Uri(path: PATH, queryParameters: parma);
    return uri.toString();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.payment_transfer_to.tr(),
          onBack: () => Navigator.pop(context, ""),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ListView(icon: "assets/images/bank/icon_scb.png",title: LocaleKeys.bank_scb.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_kp.png",title: LocaleKeys.bank_kbank.tr(),context: context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _ListView({String icon,String title,BuildContext context}){
    return GestureDetector(
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              icon,
              width: 35,
              height: 35,
            ),
            title: Text(title,
                style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
            trailing: title_val==title?SvgPicture.asset(
              "assets/images/Icon_check_circle.svg",
              width: 15,
              height: 15,
            ):SizedBox(),
          ),
          Divider(color: Color(ColorUtils.hexToInt("#C5C5C5")))
        ],
      ),
      onTap: (){
        Navigator.pop(context, title);
      },
    );
  }
}
