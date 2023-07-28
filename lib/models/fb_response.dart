class FbResponse {
  final String message;
  final bool success;
  final String? verificationId;

  FbResponse(this.message, this.success, {this.verificationId});
}
