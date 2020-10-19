import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class TransfertoPage extends StatelessWidget {

  static const String PATH = '/transferto';

  final title_val;


  const TransfertoPage({Key key, this.title_val}) : super(key: key);


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
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Transfer from",
          onBack: () => Navigator.pop(context, ""),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ListView(icon: "assets/images/bank/icon_scb.png",title: "Siam Commercial Bank (SCB)",context: context),
                      _ListView(icon: "assets/images/bank/icon_kp.png",title: "Kasikorn Bank (KBank)",context: context)
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
                style: GoogleFonts.kanit()),
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
