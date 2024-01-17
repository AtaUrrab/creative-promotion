import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

String getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );
}

launchPrivacyPolicyURL() async {
  final Uri url = Uri.parse('https://sapphiretechnologies.us/privacy-policy/');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
