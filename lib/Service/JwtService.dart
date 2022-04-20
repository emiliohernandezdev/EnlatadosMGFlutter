import 'package:jwt_decoder/jwt_decoder.dart';

class JwtService {
  String decodeToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken.toString();
  }
}
