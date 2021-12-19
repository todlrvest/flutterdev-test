import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tolr_app/components/todlr_page_state_widget.dart';
import 'package:tolr_app/data/crypto/aes_cipher.dart';
import 'package:tolr_app/data/models/questionaire_response_model.dart';
import 'package:tolr_app/data/network/repository/questions_repository.dart';
import 'package:tolr_app/utils/todlr_app_strings.dart';

enum QuestionStage { finance, investment, risk }

class QuestionsController with ChangeNotifier {
  PageState pageState = PageState.loaded;
  late QuestionsList questionData;
  Map<String, Answers> get chosenValueListDisplay => _chosenValueListDisplay;

  final Map<String, Answers> _chosenValueListDisplay = {};

  dynamic get dataList {
    switch (questionStage) {
      case QuestionStage.finance:
        return questionData.yourCurrentFinancialSituation;
      case QuestionStage.investment:
        return questionData.yourInvestmentGoalsAndObjectives;
      case QuestionStage.risk:
        return questionData.yourRiskProfile;
    }
  }

  String get titleMessage {
    switch (questionStage) {
      case QuestionStage.finance:
        return financeTitle;
      case QuestionStage.investment:
        return investmentTitle;
      case QuestionStage.risk:
        return riskTitle;
    }
  }

  String get descriptionMessage {
    switch (questionStage) {
      case QuestionStage.finance:
        return financeDescription;
      case QuestionStage.investment:
        return investmentDescription;
      case QuestionStage.risk:
        return riskDescription;
    }
  }

  QuestionStage questionStage = QuestionStage.finance;

  QuestionsController() {
    fetchQuestions();
  }

  setQuest({required String key, required Answers answer}) {
    _chosenValueListDisplay[key] = answer;
    notifyListeners();
  }

  updateQuestionPage(int pageCount) {
    switch (pageCount) {
      case 0:
        questionStage = QuestionStage.finance;
        break;
      case 1:
        questionStage = QuestionStage.investment;
        break;
      case 2:
        questionStage = QuestionStage.risk;
        break;
    }
    notifyListeners();
  }

  Answers? getValues(String item) {
    return chosenValueListDisplay[item];
  }

  fetchQuestions() async {
    try {
      pageState = PageState.loading;
      notifyListeners();
      var data = await QuestionsRepository().fetchQuestions();

      if (data.success!) {
        var decryptedQuestions =
            await AESCipher().decrypt(data.data.toString());
        questionData = QuestionsList.fromJson(json.decode(decryptedQuestions));

        pageState = PageState.loaded;
        notifyListeners();
      } else {
        pageState = PageState.error;
        notifyListeners();
      }
    } catch (_) {
      pageState = PageState.error;
      notifyListeners();
    }
  }
}
