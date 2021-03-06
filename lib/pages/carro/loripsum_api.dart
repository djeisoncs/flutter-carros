import 'package:http/http.dart' as http;

class LoripsumApi {

  static Future<String> getLoripsum() async {
    var url = 'https://loripsum.net/api';

    print("Get > $url");

    var response = await http.get(Uri.parse(url));

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}