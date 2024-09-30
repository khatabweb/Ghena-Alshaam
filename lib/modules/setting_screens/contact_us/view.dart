
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/core/validate/validation.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/contact_us_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_button.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/text_field/custom_text_field.dart';
import 'package:ghena_alshaam/modules/widgets/webview_scaffold.dart';

import '../../../new_version/new_bar.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final cubit = ContactCubit.of(context);
    return Scaffold(
      appBar: customAppBar(context, 'اتصل بنا',
          showArrowBackIcon: false, showCart: true, showLogo: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: cubit.contactKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: cubit.nameController,
                      hint: 'اسم المستخدم',
                      verticalPadding: 10,
                      validate: Validations.name,
                      prefixIcon:
                          const Icon(Icons.person, color: kPrimaryColor),
                    ),

                    CustomTextField(
                      controller: cubit.mailController,
                      hint: 'البريد الالكتروني',
                      verticalPadding: 10,
                      validate: Validations.email,
                      prefixIcon: const Icon(Icons.email, color: kPrimaryColor),
                    ),

                    CustomTextField(
                      controller: cubit.messageController,
                      verticalPadding: 10,
                      lines: 5,
                      hint: 'اترك رسالتك',
                      validate: Validations.any,
                    ),

                    /// button
                    BlocBuilder<ContactCubit, BaseState>(
                      builder: (context, state) {
                        return state is LoadingState
                            ? const CustomLoading()
                            : CustomButton(
                                text: 'ارسال',
                                onTap: () => cubit.onContactUs(context),
                                bottomPadding: 25,
                                topPadding: 25,
                                color: kGreenColor,
                              );
                      },
                    ),

                    /// divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _DrawSocialIcon("instagram.png",
                            "https://www.instagram.com/bwksmlzym/"),
                        Column(
                          children: [
                            _DrawSocialIcon(
                                "whatsapp.png", "https://wa.me/+9660551045568"),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: kPrimaryColor,
                                child:
                                    SingleText(text: 'او', color: Colors.white),
                              ),
                            ),
                            _DrawSocialIcon("twitter.png",
                                "https://mobile.twitter.com/ayman12399?lang=ar"),
                          ],
                        ),
                        _DrawSocialIcon("snapchat.png",
                            "https://www.snapchat.com/add/abo52209"),
                        // Expanded(child: Container(height: 1, color: kPrimaryColor)),

                        // Expanded(child: Container(height: 1, color: kPrimaryColor)),
                      ],
                    ),

                    /// social media
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 25),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: const [
                    //       _DrawSocialIcon("snapchat.png",
                    //           "https://www.snapchat.com/add/abo52209"),
                    //       _DrawSocialIcon(
                    //           "whatsapp.png", "https://wa.me/+9660551045568"),
                    //       _DrawSocialIcon("twitter.png",
                    //           "https://mobile.twitter.com/ayman12399?lang=ar"),
                    //       _DrawSocialIcon("instagram.png",
                    //           "https://www.instagram.com/bwksmlzym/"),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            NewsBar()
          ],
        ),
      ),
    );
  }
}

class _DrawSocialIcon extends StatelessWidget {
  final String image;
  final String url;
  const _DrawSocialIcon(this.image, this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorHelper.push(context, WebViewScaffold(url)),
      child: Image.asset(
        getIcons(image),
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
      ),
    );
  }
}
