import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/services/auth_service.dart';

void main() {
  group('AuthService.login', () {
    test('rejects short username', () {
      final result = AuthService.login('ab', 'longpassword');

      expect(result.success, isFalse);
      expect(result.error, contains('Username'));
    });

    test('rejects short password', () {
      final result = AuthService.login('beknur', '123');

      expect(result.success, isFalse);
      expect(result.error, contains('Password'));
    });

    test('accepts valid credentials and trims username', () {
      final result = AuthService.login('  beknur  ', 'secret123');

      expect(result.success, isTrue);
      expect(result.username, 'beknur');
      expect(result.error, isNull);
    });
  });
}
