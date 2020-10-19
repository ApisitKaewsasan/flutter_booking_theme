import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MySavedPage extends StatefulWidget {

  static const String PATH = '/mysave';

  @override
  _MySavedPageState createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToobar(
      header_type: Header_Type.barnon,
      Title: "Saved",
      onBack: () => Navigator.pop(context, false),
    ),
     body: SingleChildScrollView(
       child: Container(
         color: Colors.white,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             CardSection(image: "https://lh3.googleusercontent.com/proxy/vA_2gsSwPgPmdhUXF8lnoZh4gJSY0icjQ-yho6NGWooX_oGvvkttK3-eY1ID8KoF2iWCv7qoDmlZXsFtdbqb30M9hk8E8QISG7MoiIupNtrJ"),
             CardSection(image: "https://cf.bstatic.com/images/hotel/max1024x768/157/157704668.jpg"),
             CardSection(image: "https://lebua.com/wp-content/uploads/2019/07/02.-TCL_-Hangover-Suite-–-3BR.jpg")
           ],
         ),
       ),
     ),
    );
  }

  Widget CardSection({String image}) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                height: 160,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) => Lottie.asset('assets/json/loading.json',height: 160),
                fit: BoxFit.cover,
                imageUrl: image,
                errorWidget: (context, url, error) => Container(height: 160,child: Icon(Icons.error,size: 40,)),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Deluxe Room",
                    style: GoogleFonts.kanit(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              Text("2nd floor with mountain view",
                  style: GoogleFonts.kanit(
                      fontSize: 13, fontWeight: FontWeight.w300),maxLines: 1,),
                Row(
                  children: [
                    SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                        print(v);
                      },
                      starCount: 5,
                      rating: 2.5,
                      size: 20.0,
                      color: Env.value.secondaryColor,
                      borderColor: Env.value.secondaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("2.5",
                        style: GoogleFonts.kanit(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Env.value.secondaryColor))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("฿500",
                        style: GoogleFonts.kanit(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Env.value.secondaryColor)),
                    Text("nightly price per room",
                        style: GoogleFonts.kanit(
                            fontSize: 13, fontWeight: FontWeight.w300)) ,
                    SizedBox(
                      height: 8,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      child: Container(
                        width: 120,
                        height: 32,
                        color: Env.value.secondaryColor,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Env.value.secondaryColor,
                          // onPressed: () =>_validate(),
                          child: Text("View Details",
                              style: GoogleFonts.kanit(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

