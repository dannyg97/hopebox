import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/api_exception.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:my_app/api_base_helper.dart';
import 'dart:convert';

class MockHttpClient extends Mock implements http.Client {}

void main() {
    String url = "/text/analytics/v2.1/sentiment";
    Map<String, String> headers = {
        "Content-Type": "application/json",
        "Ocp-Apim-Subscription-Key": "054b278f93b84d528a6efad7bf7d00ed"
    };
    String body = '{"documents": [{"id": "1","score": 0.993499755859375}], "errors": []}';
    String validResponseBody = '{"documents": [{"id": "1","score": 0.993499755859375}],"errors": []}';
    String validResponseBodyWithError = '{"documents": [],"errors": [{"message":"Oops something went wrong."}]}';
    
    group('post', () {
        var mockHttpClient = MockHttpClient();
        ApiBaseHelper apiBaseHelper = new ApiBaseHelper(mockHttpClient);

        test('Expect when a 200 status response is received from the post method, a valid score is returned.', () async {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBody, 200));

            expect(await apiBaseHelper.post(url, headers, body), json.decode(validResponseBody));
        });

        test('When response code is 400 BadRequestException is thrown', () async {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBody, 400));

            expect(() async => await apiBaseHelper.post(url, headers, body), throwsA(TypeMatcher<BadRequestException>()));
        });

        test('When response code is 401 UnauthorisedException is thrown', () async {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBody, 401));

            expect(() async => await apiBaseHelper.post(url, headers, body), throwsA(TypeMatcher<UnauthorisedException>()));
        });

        test('When response code is 403 UnauthorisedException is thrown', () async {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBody, 403));

            expect(() async => await apiBaseHelper.post(url, headers, body), throwsA(TypeMatcher<UnauthorisedException>()));
        });

        test('When response code is 500 FetchDataException is thrown', () async {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBody, 500));

            expect(() async => await apiBaseHelper.post(url, headers, body), throwsA(TypeMatcher<FetchDataException>()));
        });

        test('When response code is not 200, 400, 401, 403, 500 a FetchDataException is thrown', () async {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBody, 501));

            expect(() async => await apiBaseHelper.post(url, headers, body), throwsA(TypeMatcher<FetchDataException>()));
        });

        test('When the response body has valid errors array, throws SentimentAnalysisException', () {
            when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(validResponseBodyWithError, 400));

            expect(() async => await apiBaseHelper.post(url, headers, body), throwsA(TypeMatcher<SentimentAnalysisException>()));
        });
    });
}