import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tolr_app/components/todlr_app_bar.dart';
import 'package:tolr_app/components/todlr_button.dart';
import 'package:tolr_app/components/todlr_dropdown.dart';
import 'package:tolr_app/components/todlr_scaffold.dart';
import 'package:tolr_app/data/controller/questions_controller.dart';
import 'package:tolr_app/data/models/questionaire_response_model.dart';
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
                        color: textV1,
                        fontWeight: FontWeight.w700,
                        height: 1.6),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      homeController.descriptionMessage,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: textV3, fontWeight: FontWeight.normal),
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
                                  hintText(item).toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: textV3,
                                          fontWeight: FontWeight.bold),
                                ),
                                isExpanded: true,
                                isDense: true,
                                underline: Container(),
                                value: homeController
                                        .getValues(hintText(item).toString()) ??
                                    answerText(item)![0],
                                items: answerText(item)!
                                    .map(
                                      (a) => DropdownMenuItem(
                                          value: a,
                                          child: Text(a.label.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: textV1,
                                                      fontWeight:
                                                          FontWeight.normal))),
                                    )
                                    .toList(),
                                onChanged: (v) => homeController.setQuest(
                                      key: hintText(item).toString(),
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
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}

String? hintText(dynamic y) {
  if (y is YourCurrentFinancialSituation) {
    return y.question;
  } else if (y is YourInvestmentGoalsAndObjectives) {
    return y.question;
  } else if (y is YourRiskProfile) {
    return y.question;
  }
  return null;
}

List<Answers>? answerText(dynamic y) {
  if (y is YourCurrentFinancialSituation) {
    return y.answers;
  } else if (y is YourInvestmentGoalsAndObjectives) {
    return y.answers;
  } else if (y is YourRiskProfile) {
    return y.answers;
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
