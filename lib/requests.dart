import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Stream<String>> fetchComparison(
  String text1,
  String text2,
  String language,
) async {
  final client = http.Client();
  final uri = Uri.parse('${dotenv.env["API_URL"]}/compare');
  final request = http.Request('POST', uri);

  request.headers.addAll({
    HttpHeaders.contentTypeHeader: 'application/json',
    'Accept': 'text/event-stream',
  });

  request.body = jsonEncode(<String, String>{
    'text1': text1,
    'text2': text2,
    'language': language,
  });

  log(request.body);

  final response = await client.send(request);

  final stream = response.stream
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  return stream;
}
