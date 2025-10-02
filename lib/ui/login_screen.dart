import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/auth_services.dart';
import 'sign_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  final _storage = const FlutterSecureStorage();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  String _errorMassage = '';
  bool _isErrorVisible = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
      _isErrorVisible = false;
    });

    final result = await _authService.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if(mounted) {
      if(result['success']) {
        await _storage.write(key: 'jwt_token', value: result['token']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false,
        );
      } else {
        setState(() {
          _errorMassage = result['message'] ?? 'Terjadi kesalahan, coba lagi.';
          _isErrorVisible = true;
        });
      }
    }
  }

  Widget _buildErrorBox() {
    return Visibility(
      visible: _isErrorVisible,
      child: Container(
        margin: const EdgeInsets.only(top: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 20),
            const SizedBox(width: 12.0),
            Text(
              _errorMassage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontFamily: 'Inika',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final double maxInputWidth = screenWidth * 0.8;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 90),
                Image.asset(
                  'assets/image/doctor-vector.png',
                  height: 150,
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inika',
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(112, 150, 209, 1),
                  ),
                ),
                const SizedBox(height: 32.0),

                Center(
                  child: SizedBox(
                    width: maxInputWidth,
                    child: Text(
                      'Alamat Email',
                      style: TextStyle(
                        fontFamily: 'Inika',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                ),  
                const SizedBox(height: 3.0),
                Center(
                  child: Container(
                    width: maxInputWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Center(
                  child: SizedBox(
                    width: maxInputWidth,
                    child: Text(
                      'Kata Sandi',
                      style: TextStyle(
                        fontFamily: 'Inika',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                ),  
                const SizedBox(height: 3.0),
                Center(
                  child: Container(
                    width: maxInputWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; 
                            });
                          }
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Center(
                  child: Container(
                    width: maxInputWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: Color.fromRGBO(90, 157, 255, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ) : const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Inika',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),       
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Belum Punya Akun ? ',
                      style: TextStyle(
                        fontFamily: 'Inika',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Inika',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(112, 150, 209, 1),
                        ),
                      ),
                    ),
                  ],
                ),

                Center(
                  child: SizedBox(
                    width: maxInputWidth,
                    child: _buildErrorBox(),
                  ),
                ),

              ],
            ), 
          ),
        ),
      ),
    );
  }
}