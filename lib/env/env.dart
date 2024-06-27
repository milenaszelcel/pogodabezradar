import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
    path:
        '.env') //give full path here with name like secret.env instead of only extension
abstract class Env {
  @EnviedField(varName: 'API_KEY')
  static const String api_key = _Env.api_key;
  @EnviedField(varName: 'URL')
  static const String url = _Env.url;
  @EnviedField(varName: 'EMAIL')
  static const String email = _Env.email;
}
