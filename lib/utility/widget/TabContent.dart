import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TabContent extends StatefulWidget {

  final Function() onTab;

  const TabContent({Key key, this.onTab}) : super(key: key);



  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  bool Tab1 = true;
  bool Tab2 = false;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_HeaderTab(), Tab1 ? _Tabconent1() : _Tabconent2()],
    );
  }

  Widget _HeaderTab() {
    return Container(
      margin: EdgeInsets.only(bottom: 35),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              child: Center(
                  child: Column(
                children: [
                  Text("Details",
                      style: GoogleFonts.kanit(
                          fontSize: 16,
                          color: Tab1
                              ? Colors.black
                              : Color(ColorUtils.hexToInt("#858585")))),
                  Visibility(
                    visible: Tab1,
                    child: _lineTab(),
                  )
                ],
              )),
              onTap: () {
                setState(() {
                  if(!Tab1){
                    Tab1 = !Tab1 ? true : false;
                    Tab2 = Tab2 ? false : true;
                    widget.onTab();
                  }

                });
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Center(
                  child: Column(
                children: [
                  Text("Reviews",
                      style: GoogleFonts.kanit(
                          fontSize: 16,
                          color: Tab2
                              ? Colors.black
                              : Color(ColorUtils.hexToInt("#858585")))),
                  Visibility(
                    visible: Tab2,
                    child: _lineTab(),
                  )
                ],
              )),
              onTap: () {
                setState(() {
                  if(!Tab2){
                    Tab1 = Tab1 ? false : true;
                    Tab2 = !Tab2 ? true : false;
                    widget.onTab();
                  }

                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _Tabconent1() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.",
            style: GoogleFonts.kanit(
                color: Color(ColorUtils.hexToInt("#858585")))),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                _NeedObject(
                    label: "Free WiFi",
                    icon: "assets/images/Icon_wifi.svg",
                    size: 15),
                _NeedObject(
                    label: "Air Conditioning",
                    icon: "assets/images/Icon_snow.svg",
                    size: 20),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                _NeedObject(
                    label: "No Smoking",
                    icon: "assets/images/Icon_smoking.svg",
                    size: 20),
                _NeedObject(
                    label: "Cable TV",
                    icon: "assets/images/Icon_tv.svg",
                    size: 15),
              ],
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text("Activity & Facilities",
                style: GoogleFonts.kanit(fontSize: 18)),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Fitness Centre")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Shampoo")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Mini Bar")
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Fitness Centre")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Shampoo")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.done),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Mini Bar")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _NeedObject({String label, String icon, double size}) {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: size,
            height: size,
            color: Env.value.secondaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(label)
        ],
      ),
    );
  }

  Widget _lineTab() {
    return Container(
        width: 45,
        height: 4,
        decoration: BoxDecoration(
            color: Env.value.secondaryColor,
            border: Border.all(
              color: Env.value.secondaryColor,
              width: 3.0,
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(8.0) //                 <--- border radius here
                )));
  }

  Widget _Tabconent2() {
    return Container(
      child: Column(
        children: [
          _contentReview(image: "https://pyxis.nymag.com/v1/imgs/55b/438/d732205198d1fc4b0aafc8bb302e4e68c2-john-wick.2x.rsocial.w600.jpg"),
          _contentReview(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR7AWVrm7tyBCdrkOm4blfv5mzpizKb8s-WlQ&usqp=CAU"),
          _contentReview(image: "https://upload.wikimedia.org/wikipedia/commons/3/31/Emma_Stone_at_Maniac_UK_premiere_%28cropped%29.jpg")
        ],
      ),
    );
  }

  Widget _contentReview({String image}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                height: 35,
                width: 10,
                fit: BoxFit.cover,
                imageUrl: image,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Text("Wick John",
                                  style: GoogleFonts.kanit(fontSize: 14)),
                              SizedBox(width: 10,),
                              Text("(5 days ago)",
                                  style: GoogleFonts.kanit(fontSize: 11,color: Color(ColorUtils.hexToInt("#858585"))))
                            ],
                          )),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SmoothStarRating(
                              allowHalfRating: true,
                              onRated: (v) {
                                print(v);
                              },
                              starCount: 5,
                              rating: 2.5,
                              size: 15.0,
                              color: Env.value.secondaryColor,
                              borderColor: Env.value.secondaryColor,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.",
                      style: GoogleFonts.kanit(fontSize: 12,color: Color(ColorUtils.hexToInt("#858585"))))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelDone(String label) {
    return Expanded(
      child: Row(
        children: [
          Icon(Icons.done),
          SizedBox(
            width: 10,
          ),
          Text(label)
        ],
      ),
    );
  }
}
