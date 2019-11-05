import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/mood_entry.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:my_app/api_base_helper.dart';
import 'dart:convert';

class MockApiBaseHelper extends Mock implements ApiBaseHelper {}

void main() {
    // The sentiment analysis returns a value between 0 and 100.
    group('transformScoreToMood', () {
        SentimentAnalysisHelper sentimentAnalysisHelper = SentimentAnalysisHelper(http.Client());
        test('should return 0 when 0 < score < 20', () {
            int score = sentimentAnalysisHelper.transformScoreToMoodScale(10);
            expect(score, 0);
        });

        test('should return 1 when 20 <= score < 40', () {
            int score = sentimentAnalysisHelper.transformScoreToMoodScale(30);
            expect(score, 1);
        });

        test('should return 2 when 40 <= score < 60', () {
            int score = sentimentAnalysisHelper.transformScoreToMoodScale(50);
            expect(score, 2);
        });

        test('should return 3 when 60 <= score < 80', () {
            int score = sentimentAnalysisHelper.transformScoreToMoodScale(70);
            expect(score, 3);
        });

        test('should return 4 when 80 <= score < 100', () {
            int score = sentimentAnalysisHelper.transformScoreToMoodScale(90);
            expect(score, 4);
        });
    });

    group('analyseTextSentiment', () {
        test('Expect when a 200 status response is received from the post method, a valid score is returned.', () async {
            var mockApiBaseHelper = MockApiBaseHelper();
            SentimentAnalysisHelper sentimentAnalysisHelper = SentimentAnalysisHelper(mockApiBaseHelper);
            when(mockApiBaseHelper.post(any, any, any))
                .thenAnswer((_) async => json.decode('{"documents": [{"id": "1","score": 0.993499755859375}], "errors": []}'));

            expect(await sentimentAnalysisHelper.analyseTextSentiment("text"), 4);
        });
    });

    group('getSentimentAnalysis', () {
        SentimentAnalysisHelper sentimentAnalysisHelper = SentimentAnalysisHelper(http.Client());
        test('Expect when the response body has the correct object properties, a score > -1 is returned', () {
            var responseBody = json.decode('{"documents": [{"id": "1","score": 0.993499755859375}], "errors": []}');
            int score = sentimentAnalysisHelper.getSentimentAnalysisScore(responseBody);

            expect(score, greaterThan(-1));
        });

        test('Expect when the response body has an empty documents array, -1 is returned', () {
            var responseBody = json.decode('{"documents": [], "errors": []}');
            int score = sentimentAnalysisHelper.getSentimentAnalysisScore(responseBody);

            expect(score, -1);
        });

        test('Expect when the response body has a null element in documents array, -1 is returned', () {
            var responseBody = json.decode('{"documents": [null], "errors": []}');
            int score = sentimentAnalysisHelper.getSentimentAnalysisScore(responseBody);

            expect(score, -1);
        });

        test('Expect when the response body has an element in documents array but no score property, -1 is returned', () {
            var responseBody = json.decode('{"documents": [{"notScore":"1"}], "errors": []}');
            int score = sentimentAnalysisHelper.getSentimentAnalysisScore(responseBody);

            expect(score, -1);
        });
    });
}