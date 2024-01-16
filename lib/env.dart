import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.local')
abstract class Env {
  @EnviedField(varName: 'DATASOURCE')
  static const String dataSource = _Env.dataSource;

  @EnviedField(varName: 'API_URL', obfuscate: true)
  static final String apiUrl = _Env.apiUrl;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;

  @EnviedField(varName: 'API_SECRET_KEY', obfuscate: true)
  static final String apiSecretKey = _Env.apiSecretKey;
}
