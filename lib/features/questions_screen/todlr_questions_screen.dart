import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tolr_app/components/todlr_app_bar.dart';
import 'package:tolr_app/components/todlr_button.dart';
import 'package:tolr_app/components/todlr_dropdown.dart';
import 'package:tolr_app/components/todlr_scaffold.dart';
import 'package:tolr_app/data/controller/questions_controller.dart';
import 'package:tolr_app/data/models/questionaire_response_model.dart';
import 'package:tolr_app/features/questions_screen/todlr_investment_final_profile.dart';
import 'package:tolr_app/utils/todlr_app_strings.dart';
import 'package:tolr_app/utils/todlr_colors.dart';

class TodlrQuestionsScreen extends StatefulWidget {
  const TodlrQuestionsScreen({Key? key}) : super(key: key);

  @override
  _TodlrQuestionsScreenState createState() => _TodlrQuestionsScreenState();
}

class _TodlrQuestionsScreenState extends State<TodlrQuestionsScreen> {
  late QuestionsController homeController;
  int pageCount = 0;

  @override
  Widget build(BuildContext context) {
    homeController = Provider.of<QuestionsController>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        if (pageCount == 0) {
          return true;
        } else {
          pageCount--;
          homeController.updateQuestionPage(pageCount);
          return false;
        }
      },
      child: TodlrNPScaffold(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        appBar: TodlrAppBar(),
        state: AppState(pageState: homeController.pageState),
        builder: (context) => Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Text(
                    homeController.titleMessage,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: textV1Colour,
                        fontWeight: FontWeight.w700,
                        height: 1.6),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      homeController.descriptionMessage,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: textV3Colour, fontWeight: FontWeight.normal),
                    ),
                  ),
                  ...enumerate(
                      homeController.dataList,
                      (index, item) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: COXDropdownButton<Answers>(
                                itemsListTitle: selectOption,
                                iconSize: 22,
                                hint: Text(
                                  getQuestion(item).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: textV3Colour,
                                          fontWeight: FontWeight.bold),
                                ),
                                isExpanded: true,
                                isDense: true,
                                underline: Container(),
                                value: homeController.getValues(
                                        getQuestion(item).toString()) ??
                                    getAnswer(item)![0],
                                items: getAnswer(item)!
                                    .map(
                                      (a) => DropdownMenuItem(
                                          value: a,
                                          child: Text(a.label.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: textV1Colour,
                                                      fontWeight:
                                                          FontWeight.normal))),
                                    )
                                    .toList(),
                                onChanged: (v) => homeController.setQuest(
                                      key: getQuestion(item).toString(),
                                      answer: v,
                                    )),
                          )).toList(),
                ],
              ),
            ),
            TodlrButton(
              title: continueText,
              callback: () {
                if (pageCount < 2) {
                  pageCount++;
                  homeController.updateQuestionPage(pageCount);
                } else {
                  homeController.questionStage = QuestionStage.finance;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const TodlrInvestmentFinalProfile()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String? getQuestion(dynamic item) {
  if (item is YourCurrentFinancialSituation) {
    return item.question;
  } else if (item is YourInvestmentGoalsAndObjectives) {
    return item.question;
  } else if (item is YourRiskProfile) {
    return item.question;
  }
  return null;
}

List<Answers>? getAnswer(dynamic item) {
  if (item is YourCurrentFinancialSituation) {
    return item.answers;
  } else if (item is YourInvestmentGoalsAndObjectives) {
    return item.answers;
  } else if (item is YourRiskProfile) {
    return item.answers;
  }
  return null;
}

Iterable<E> enumerate<E, T>(
    Iterable<T> items, E Function(int index, T item) f) {
  var index = 0;
  return items.map((item) {
    final result = f(index, item);
    index = index + 1;
    return result;
  });
}
