import 'package:tolr_app/data/models/questions_data_response_model.dart';
import 'package:tolr_app/data/network/http_request.dart';
import 'package:tolr_app/data/network/routes/route_path.dart';

class QuestionsRepository {
  Future<QuestionDataResponse> fetchQuestions() async {
    var responseData = await ServerData().getData(path: Routes.getQuestions);
    return QuestionDataResponse.fromJson(responseData.data);
  }
}
