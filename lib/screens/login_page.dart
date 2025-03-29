class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      final token = await _authService.signInWithGoogle();
                      setState(() => _isLoading = false);
                      _handleLoginResult(token);
                    },
                    child: Text('Sign in with Google'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      final token = await _authService.signInWithFacebook();
                      setState(() => _isLoading = false);
                      _handleLoginResult(token);
                    },
                    child: Text('Sign in with Facebook'),
                  ),
                  if (Platform.isIOS) // Only show Apple Sign-In on iOS
                    ElevatedButton(
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        final token = await _authService.signInWithApple();
                        setState(() => _isLoading = false);
                        _handleLoginResult(token);
                      },
                      child: Text('Sign in with Apple'),
                    ),
                ],
              ),
      ),
    );
  }

  void _handleLoginResult(String? token) {
    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainAppScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }
}

class MainAppScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // ... (MainAppScreen code from previous example)
    return Scaffold(
        appBar: AppBar(title: Text("Main App")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome!"),
              ElevatedButton(
                  onPressed: () async {
                    await _authService.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                  child: Text("Sign Out")),
              ElevatedButton(
                  onPressed: () async {
                    final response = await _authService.authenticatedRequest(
                        "$_authService._backendUrl/api/protected");
                    if (response != null && response.statusCode == 200) {
                      print(response.body);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response.body)));
                    } else {
                      print("Protected route failed, or was null");
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Protected route failed")));
                    }
                  },
                  child: Text("Protected Route"))
            ],
          ),
        ));
  }
}
