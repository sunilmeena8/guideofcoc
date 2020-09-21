import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  static launchURL(String copyURL) async {
    String url = copyURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
