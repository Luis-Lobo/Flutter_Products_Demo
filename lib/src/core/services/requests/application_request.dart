abstract class ApplicationRequest {
  final String path;
  final Map<String, dynamic> header;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;

  const ApplicationRequest({
    required this.path,
    required this.header,
    this.body,
    this.queryParameters,
  });
}
