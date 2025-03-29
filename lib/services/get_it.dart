final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
}

// Then use it anywhere with:
final authService = getIt<AuthService>();