

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


final List<String> imgList = [
  'https://st.hzcdn.com/simgs/pictures/bedrooms/abbot-ave-unit-h-christopher-lee-foto-img~1131a6990e8f8fcb_14-3211-1-404364d.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/bedroom-ideas-rds-work-queens-road-08-1593114639.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS3HGmWJ04BP2BazlEQgf-K959TO5CvbCTyuA&usqp=CAU'
];

class SliderImage extends StatefulWidget {

 final double height;

  const SliderImage({Key key, this.height}) : super(key: key);

  @override
  _SliderImageState createState() => _SliderImageState();
}


class _SliderImageState extends State<SliderImage> {

  String page;
  final CarouselController _controller = CarouselController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = "1/${imgList.length}";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: imgList.length,
          itemBuilder: (BuildContext context, int itemIndex) =>
              Container(
                child: _cardSilder(url: imgList[itemIndex]),
              ),
            options: CarouselOptions(
                enlargeCenterPage: false,
                height: widget.height,
                viewportFraction: 1.0,
                autoPlayCurve: Curves.linearToEaseOut,
                onPageChanged: (index, reason) {
                  setState(() {
                    page = "${index + 1}/${imgList.length}";
                  });
                }),
            carouselController: _controller,
          ),
          Container(
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Icon(Ionicons.ios_arrow_back,
                          color: Colors.white, size: 30),
                      onTap: () {
                        _controller.previousPage();
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      page,
                      style:
                      GoogleFonts.kanit(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Icon(Ionicons.ios_arrow_forward,
                          color: Colors.white, size: 30),
                      onTap: () {
                        _controller.nextPage();
                      },
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

  Widget _cardSilder({String url}){
    return Container(
      child: Container(
        child: ClipRRect(
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  placeholder: (context, url) => Lottie.asset(Env.value.loadingAnimaion,height: widget.height),
                  fit: BoxFit.cover,
                  imageUrl: url,
                  errorWidget: (context, url, error) => Container(height: widget.height,child: Icon(Icons.error,size: 40,)),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                  ),
                ),
              ],
            )),
      ),
    );
  }



}
