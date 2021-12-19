import 'package:flutter/material.dart';
import 'package:tolr_app/components/todlr_button.dart';
import 'package:tolr_app/components/todlr_scaffold.dart';
import 'package:tolr_app/features/questions_screen/todlr_questions_screen.dart';
import 'package:tolr_app/utils/todlr_app_strings.dart';
import 'package:tolr_app/utils/todlr_colors.dart';
import 'package:tolr_app/utils/todlr_images.dart';

class TodlrWelcomeLanderScreen extends StatelessWidget {
  const TodlrWelcomeLanderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget landerTextTitle(String title, {color}) {
      return Text(
        title,
        style: Theme.of(context).textTheme.headline2!.copyWith(
            color: color ?? textV2, fontWeight: FontWeight.w700, height: 1.6),
        textAlign: TextAlign.center,
      );
    }

    return TodlrNPScaffold(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
      builder: (context) => Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset(TodlrImages.logoIcon)),
                landerTextTitle(createLander),
                landerTextTitle(personalised),
                landerTextTitle(portfolio, color: primaryColor),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    landerDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: textV1,
                          fontWeight: FontWeight.normal,
                          height: 1.6,
                        ),
                  ),
                ),
              ],
            ),
          ),
          TodlrButton(
            title: start,
            callback: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TodlrQuestionsScreen())),
          ),
        ],
      ),
    );
  }
}
