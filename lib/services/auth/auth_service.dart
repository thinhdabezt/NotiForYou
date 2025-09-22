import 'package:notiforyou/services/auth/auth_provider.dart';
import 'package:notiforyou/services/auth/auth_user.dart';
import 'package:notiforyou/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);
  
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  AuthUser? get currentUser => provider.currentUser;
  
  @override
  Future<AuthUser> login({required String email, required String password}) {
    return provider.login(email: email, password: password);
  }
  
  @override
  Future<void> logout() {
    return provider.logout();
  }
  
  @override
  Future<AuthUser> register({required String email, required String password}) {
    return provider.register(email: email, password: password);
  }
  
  @override
  Future<void> sendEmailVerification() {
    return provider.sendEmailVerification();
  }
  
  @override
  Future<void> initialize() async {
    await provider.initialize();
  }
}