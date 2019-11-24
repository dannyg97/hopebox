import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'api_exception.dart';

class ApiBaseHelper {

    final String _baseUrl = "https://hopebox-sentiment-analysis.cognitiveservices.azure.com";
    final _httpClient;
    ApiBaseHelper([this._httpClient]);

    Future<dynamic> post(String url, Map<String, String> headers, String body) async {
        var responseJson;
        try {
            final response = await this._httpClient.post(
                _baseUrl + url, headers: headers, body: body);

            responseJson = _returnResponse(response);
        } on SocketException {
            throw FetchDataException('No Internet connection');
        }
        return responseJson;
    }

    dynamic _returnResponse(http.Response response) {
        var parsedBody = json.decode(response.body);
        List errors = parsedBody['errors'];
        if (errors.length > 0 &&
            parsedBody['errors'][0] != null &&
            parsedBody['errors'][0]['message'] != null) {
            throw SentimentAnalysisException(
                parsedBody['errors'][0]['message']);
        }
        switch (response.statusCode) {
            case 200:
                var responseJson = json.decode(response.body.toString());
                return responseJson;
            case 400:
                throw BadRequestException(response.body.toString());
            case 401:
            case 403:
                throw UnauthorisedException(response.body.toString());
            case 500:
            default:
                throw FetchDataException(
                    'Error occured while Communication with Server with StatusCode : ${response
                        .statusCode}');
        }
    }
}