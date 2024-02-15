import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TermsOfUseAndPrivacyPolicyTextsBuilder extends StatelessWidget {
  final String text;
  final String privacyPolicyLink;
  final String termsOfUseLink;
  final TextStyle? linkTextStyle;
  final TextStyle? textTextStyle;
  final TextAlign alignment;

  /// Default alignment is center
  const TermsOfUseAndPrivacyPolicyTextsBuilder({
    super.key,
    required this.text,
    required this.privacyPolicyLink,
    required this.termsOfUseLink,
    this.linkTextStyle,
    this.textTextStyle,
    this.alignment = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];

    // Split the string into components
    final parts = [];
    var lastIndex = 0;

    final matches = RegExp(r'<a[^>]*>.*?</a>').allMatches(text);

    for (final match in matches) {
      if (match.start > lastIndex) parts.add(text.substring(lastIndex, match.start));
      parts.add(text.substring(match.start, match.end));
      lastIndex = match.end;
    }

    if (lastIndex < text.length) parts.add(text.substring(lastIndex));

    for (final part in parts) {
      if (part.startsWith('<a')) {
        // Replace HTML-like tags with an empty string
        final String parsedText = part.replaceAll(RegExp(r'<[^>]*>'), '');

        // Parse the <a> tag for the link text
        final match = RegExp(r'<a link\s*=\s*"([^"]+)">').firstMatch(part);
        final link = match?.group(1) ?? '';

        final String url = link == 'terms' ? termsOfUseLink : privacyPolicyLink;

        // Add the link text with custom style and tap gesture
        textSpans.add(
          TextSpan(
            text: parsedText,
            style: linkTextStyle,
            // Adds onTap to the specific text
            recognizer: TapGestureRecognizer()..onTap = () => launchUrlString(url),
          ),
        );
      } else {
        // Add the non-link text with default style
        textSpans.add(TextSpan(text: part, style: textTextStyle));
      }
    }

    return RichText(text: TextSpan(children: textSpans), textAlign: alignment);
  }
}
