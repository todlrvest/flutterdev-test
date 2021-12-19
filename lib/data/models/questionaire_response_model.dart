class QuestionsList {
  final List<YourCurrentFinancialSituation>? yourCurrentFinancialSituation;
  final List<YourRiskProfile>? yourRiskProfile;
  final List<YourInvestmentGoalsAndObjectives>?
      yourInvestmentGoalsAndObjectives;

  QuestionsList({
    this.yourCurrentFinancialSituation,
    this.yourRiskProfile,
    this.yourInvestmentGoalsAndObjectives,
  });

  QuestionsList.fromJson(Map json)
      : yourCurrentFinancialSituation =
            (json['Your Current Financial Situation'] as List?)
                ?.map((dynamic e) => YourCurrentFinancialSituation.fromJson(
                    e as Map<String, dynamic>))
                .toList(),
        yourRiskProfile = (json['Your Risk Profile'] as List?)
            ?.map((dynamic e) =>
                YourRiskProfile.fromJson(e as Map<String, dynamic>))
            .toList(),
        yourInvestmentGoalsAndObjectives =
            (json['Your investment goals and objectives'] as List?)
                ?.map((dynamic e) => YourInvestmentGoalsAndObjectives.fromJson(
                    e as Map<String, dynamic>))
                .toList();

  Map<String, dynamic> toJson() => {
        'Your Current Financial Situation':
            yourCurrentFinancialSituation?.map((e) => e.toJson()).toList(),
        'Your Risk Profile': yourRiskProfile?.map((e) => e.toJson()).toList(),
        'Your investment goals and objectives':
            yourInvestmentGoalsAndObjectives?.map((e) => e.toJson()).toList()
      };
}

class YourCurrentFinancialSituation {
  final String? id;
  final String? header;
  final String? label;
  final List<Answers>? answers;
  final String? question;
  final String? createdAt;
  final String? updatedAt;

  YourCurrentFinancialSituation({
    this.id,
    this.header,
    this.label,
    this.answers,
    this.question,
    this.createdAt,
    this.updatedAt,
  });

  YourCurrentFinancialSituation.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        header = json['header'] as String?,
        label = json['label'] as String?,
        answers = (json['answers'] as List?)
            ?.map((dynamic e) => Answers.fromJson(e as Map<String, dynamic>))
            .toList(),
        question = json['question'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'header': header,
        'label': label,
        'answers': answers?.map((e) => e.toJson()).toList(),
        'question': question,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class Answers {
  final String? id;
  final String? label;
  final String? questionId;
  final int? score;
  final String? createdAt;
  final String? updatedAt;

  Answers({
    this.id,
    this.label,
    this.questionId,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  Answers.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        label = json['label'] as String?,
        questionId = json['question_id'] as String?,
        score = json['score'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'question_id': questionId,
        'score': score,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class YourRiskProfile {
  final String? id;
  final String? header;
  final String? label;
  final List<Answers>? answers;
  final String? question;
  final String? createdAt;
  final String? updatedAt;

  YourRiskProfile({
    this.id,
    this.header,
    this.label,
    this.answers,
    this.question,
    this.createdAt,
    this.updatedAt,
  });

  YourRiskProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        header = json['header'] as String?,
        label = json['label'] as String?,
        answers = (json['answers'] as List?)
            ?.map((dynamic e) => Answers.fromJson(e as Map<String, dynamic>))
            .toList(),
        question = json['question'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'header': header,
        'label': label,
        'answers': answers?.map((e) => e.toJson()).toList(),
        'question': question,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class YourInvestmentGoalsAndObjectives {
  final String? id;
  final String? header;
  final String? label;
  final List<Answers>? answers;
  final String? question;
  final String? createdAt;
  final String? updatedAt;

  YourInvestmentGoalsAndObjectives({
    this.id,
    this.header,
    this.label,
    this.answers,
    this.question,
    this.createdAt,
    this.updatedAt,
  });

  YourInvestmentGoalsAndObjectives.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        header = json['header'] as String?,
        label = json['label'] as String?,
        answers = (json['answers'] as List?)
            ?.map((dynamic e) => Answers.fromJson(e as Map<String, dynamic>))
            .toList(),
        question = json['question'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'header': header,
        'label': label,
        'answers': answers?.map((e) => e.toJson()).toList(),
        'question': question,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
