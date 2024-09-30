import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/main_screens/our_services/view.dart';
import 'package:ghena_alshaam/modules/main_screens/our_way/view.dart';
import 'package:ghena_alshaam/modules/setting_screens/about_us/view.dart';
import 'package:ghena_alshaam/modules/setting_screens/contact_us/view.dart';

class HomeIcons extends StatelessWidget {
  const HomeIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Transform.translate(
      offset: Offset(0, -1 * (screenWidth) * 0.43),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: screenWidth * 0.60,
          height: screenHeight * 0.60,
          child: ListView(

            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.25,),
              _drawIconButton('assets/icons/sheep.png', const OurServicesView(), context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _drawIconButton('assets/icons/group.png', const AboutUsView(), context),
                  _drawIconButton('assets/icons/phone.png', const ContactUsView(), context),
                ],
              ),
              _drawIconButton('assets/icons/knife.png', const OurWayView(), context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawIconButton(String iconImage, Widget page, BuildContext context) {
    return   IconButton(
        iconSize: 60.0,
        icon: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 33.0,
          backgroundImage: ExactAssetImage(iconImage),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          page),);
        });
  }
}

