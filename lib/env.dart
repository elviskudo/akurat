import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.local')
abstract class Env {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static final String apiUrl = _Env.apiUrl;
}
