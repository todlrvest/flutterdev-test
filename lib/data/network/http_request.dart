import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerData {
  Future<HttpResponse> getData({
    String? path,
  }) async {
    try {
      var response = await http
          .get(Uri.parse(path!), headers: {"Content-Type": "application/json"});

      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpData(data);
      }
    } catch (e) {
      return HttpException('something wrong happened');
    }
  }
}

abstract class HttpResponse {
  dynamic data;
}

class HttpException extends HttpResponse {
  final data;

  HttpException(this.data);
}

class HttpData extends HttpResponse {
  final data;

  HttpData(this.data);
}
