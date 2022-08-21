import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:piggy_flow_mobile/providers/firebase_auth_provider.dart';

final httpProvider = Provider<http.BaseClient>((ref) {
  return AuthenticatedHttpClient(ref);
});

class AuthenticatedHttpClient extends http.BaseClient {
  AuthenticatedHttpClient(this.ref);

  final Ref ref;

  getToken() async {
    String token = '';
    try {
      token = await ref.read(firebaseAuthProvider).currentUser!.getIdToken();
    } catch (e) {}
    return token;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String token = await getToken();

    if (token != '') {
      request.headers.putIfAbsent('authorization', () => 'Bearer $token');
    }
    return request.send();
  }
}

class ESMultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  ESMultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  http.ByteStream finalize() {
    final byteStream = super.finalize();

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
