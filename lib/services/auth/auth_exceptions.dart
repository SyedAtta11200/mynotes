// Loginveiw exception
class UserNotFoundAuthException implements Exception {
  final String message = 'User not found';
}

class WrongPasswordAuthException implements Exception {
  final String message = 'Wrong password';
}

// resister exception
class WeakPasswordAuthException implements Exception {
  final String message = 'Weak password';
}

class EmailAlreadyInUseAuthException implements Exception {
  final String message = 'Email already in use';
}

class InvalidEmailAuthException implements Exception {
  final String message = 'Invalid email address';
}

// common exception
class GenericAuthException implements Exception {
  final String message = 'Error';
}

class EmailNotLoggedInAuthException implements Exception {
  final String message = 'Email not verified';
}
