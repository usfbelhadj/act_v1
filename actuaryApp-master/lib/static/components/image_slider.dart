import 'package:actuaryapp/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "assets/images/ATCF.jpg",
  "assets/images/ATCF2.jpg",
  "assets/images/IAA.jpg",
  "assets/images/ITD.png",
  "assets/images/maroc.jpg",
];

final List<String> imgDescription = [
  "Participation de l'ATA à la journée Assurance Vie de l'ATCF Mars 2019",
  "Participation de l'ATA à la réunion ATCF CGA en Octobre 2019",
  "Participation de l'ATA au Council and Committee Meetings de l'IAA à Tokyo, Japan en Octobre 2019",
  "Participation de l'ATA à la journée Actuariat à Tunis Dauphine Mai 2019",
  "Participation de l'ATA à la rencontre FMSAR ACAPS avec CGA-FTUSA Octobre 2019",
];

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 80,

                      //color: kPrimaryColor,
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
                      padding: EdgeInsets.all(defaultPadding),
                      child: Center(
                        child: Text(
                          '${imgDescription[imgList.indexOf(item)]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            //fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    )
    .toList();

class ImageSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageSliderState();
  }
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
