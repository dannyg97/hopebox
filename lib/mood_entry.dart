class SentimentAnalysisHelper {

  String url = "/text/analytics/v2.1/sentiment";
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Ocp-Apim-Subscription-Key": "054b278f93b84d528a6efad7bf7d00ed"
  };
  int MOOD_SCALE_INTERVAL = 20;

  final _helper;

  SentimentAnalysisHelper([this._helper]);

  int getSentimentAnalysisScore(var responseBody) {
    List documents = responseBody['documents'];
    if (documents.length > 0 &&
        responseBody['documents'][0] != null &&
        responseBody['documents'][0]['score'] != null) {
      var score = responseBody['documents'][0]['score'] * 100;
      return transformScoreToMoodScale(score);
    }
    return -1;
  }

  transformScoreToMoodScale(score) {
    double transformedScore = score / MOOD_SCALE_INTERVAL;
    return transformedScore.floor();
  }

  analyseTextSentiment(String text) async {
    String body =
        '{ "documents": [{"language": "en","id": "1","text": "$text"}]}';
    try {
      final response = await this._helper.post(url, headers, body);
      int score = getSentimentAnalysisScore(response);
      return score;
    } catch (e) {
      rethrow;
    }
  }
}
