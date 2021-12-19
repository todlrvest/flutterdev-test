import 'package:flutter/material.dart';
import 'package:tolr_app/components/todlr_button.dart';
import 'package:tolr_app/components/todlr_scaffold.dart';
import 'package:tolr_app/features/onboarding/todlr_welcome_lander.dart';
import 'package:tolr_app/utils/todlr_app_strings.dart';
import 'package:tolr_app/utils/todlr_colors.dart';
import 'package:tolr_app/utils/todlr_images.dart';

class TodlrInvestmentFinalProfile extends StatelessWidget {
  const TodlrInvestmentFinalProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodlrNPScaffold(
      backgroundColor: primaryColor,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
      builder: (context) => Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset(TodlrImages.investmentLogo)),
                Text(
                  aggressive,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      investor,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset(TodlrImages.infoIcon)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    investorDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          height: 1.6,
                        ),
                  ),
                ),
              ],
            ),
          ),
          TodlrButton(
            title: next,
            backgroundColor: Colors.white,
            textColor: primaryColor,
            callback: () => {
              makeRoutePage(
                  context: context, pageRef: const TodlrWelcomeLanderScreen())
            },
          ),
        ],
      ),
    );
  }

  void makeRoutePage({required BuildContext context, required Widget pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
        (Route<dynamic> route) => false);
  }
}
