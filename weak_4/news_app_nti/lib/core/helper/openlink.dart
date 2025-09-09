import 'package:url_launcher/url_launcher.dart';

Future<void> openNewsUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not launch $url");
  }
}
