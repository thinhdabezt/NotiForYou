//Login Exceptions
class UserNotFoundAuthException implements Exception {}
class InvalidCredentialAuthException implements Exception {}
//Register Exceptions
class WeakPasswordAuthException implements Exception {}
class EmailAlreadyInUseAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}
//Generic Exception
class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}