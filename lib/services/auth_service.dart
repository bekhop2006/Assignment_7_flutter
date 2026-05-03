class AuthResult {
  const AuthResult({required this.success, this.error, this.username});

  final bool success;
  final String? error;
  final String? username;
}

class AuthService {
  static const _minUsernameLength = 3;
  static const _minPasswordLength = 6;

  static AuthResult login(String username, String password) {
    final trimmedUsername = username.trim();

    if (trimmedUsername.length < _minUsernameLength) {
      return const AuthResult(
        success: false,
        error: 'Username must be at least 3 characters',
      );
    }

    if (password.length < _minPasswordLength) {
      return const AuthResult(
        success: false,
        error: 'Password must be at least 6 characters',
      );
    }

    return AuthResult(success: true, username: trimmedUsername);
  }
}
