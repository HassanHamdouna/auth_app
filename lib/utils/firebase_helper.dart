import 'package:app_auth/models/fb_response.dart';

class FirebaseHelper {
  FbResponse get successfullyResponse =>
      FbResponse('Operation completed successfully', true);
  FbResponse get errorResponse => FbResponse('Operation failed', false);
}
