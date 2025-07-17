import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class SupabaseHttpClient extends http.BaseClient {
  final http.Client _inner;

  SupabaseHttpClient([http.Client? inner]) : _inner = inner ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final requestId = DateTime.now().millisecondsSinceEpoch;
    log('[$requestId] → ${request.method} ${request.url}');
    log('[$requestId]   headers: ${request.headers}');
    if (request is http.Request) {
      log('[$requestId]   body: ${request.body}');
    }

    final stopwatch = Stopwatch()..start();
    final streamed = await _inner.send(request);
    stopwatch.stop();

    final bytes = await streamed.stream.toBytes();
    final responseBody = utf8.decode(bytes, allowMalformed: true);

    log(
      '[$requestId] ← ${streamed.statusCode} ${request.url} '
      '(${stopwatch.elapsedMilliseconds} ms)',
    );
    log('[$requestId]   response headers: ${streamed.headers}');
    log('[$requestId]   response body: $responseBody');

    // Re-create a StreamedResponse so the caller still sees the data
    return http.StreamedResponse(
      Stream.fromIterable([bytes]),
      streamed.statusCode,
      contentLength: streamed.contentLength,
      request: streamed.request,
      headers: streamed.headers,
      isRedirect: streamed.isRedirect,
      reasonPhrase: streamed.reasonPhrase,
      persistentConnection: streamed.persistentConnection,
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
