import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isPasswordVisible = false;
  bool _isConfirmPassword = false;
  bool _isLoading = false;

  String _message = '';
  bool _isMessageVisible = false;
  bool _isError = false;

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _isMessageVisible = false;
      });

      final result = await _authService.register(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (result['success']) {
        setState(() {
          _message = result['message'] ?? 'Registrasi berhasil';
          _isError = false;
          _isMessageVisible = true;
        });

        Future.delayed(const Duration(seconds: 2), () {
          if(mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        });
      } else {
        setState(() {
          _message = result['message'] ?? 'Registrasi gagal';
          _isError = true;
          _isMessageVisible = true;
        });
      }
    }
  }

  Widget _buildMessageBox() {
    if (!_isMessageVisible) return const SizedBox.shrink();

    final Color boxColor = _isError ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1);
    final Color borderColor = _isError ? Colors.red.withOpacity(0.5) : Colors.green.withOpacity(0.5);
    final Color iconColor = _isError ? Colors.red : Colors.green;
    final IconData iconData = _isError ? Icons.error_outline : Icons.check_circle_outline;

    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: iconColor, size: 20),
          const SizedBox(width: 12.0),
          Text(
            _message,
            style: TextStyle(
              color: iconColor,
              fontSize: 14,
              fontFamily: 'Inika',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double maxInputWidth = screenWidth * 0.8;

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Inika',
                    fontSize: 37,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(112, 150, 209, 1),
                  ),
                ),
                const SizedBox(height: 50),

                SizedBox(
                  width: maxInputWidth,
                  child: const Align(
                    alignment: Alignment.centerLeft,
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
                const SizedBox(height: 3),
                Container(
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
                  child: TextFormField(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat email tidak boleh kosong';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Masukkan alamat email yang valid';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: maxInputWidth,
                  child: const Align(
                    alignment: Alignment.centerLeft,
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
                const SizedBox(height: 3),
                Container(
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
                  child: TextFormField(
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
                    validator: (value) { // Tambah
                      if (value == null || value.isEmpty) {
                        return 'Kata sandi tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Kata sandi minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                
                SizedBox (
                  width: maxInputWidth,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Konfirmasi Kata Sandi',
                      style: TextStyle(
                        fontFamily: 'Inika',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
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
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPassword = !_isConfirmPassword;
                          });
                        },
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
                    validator: (value) { // Tambah
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi kata sandi tidak boleh kosong';
                      }
                      if (value != _passwordController.text) {
                        return 'Kata sandi tidak cocok';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: maxInputWidth,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color.fromRGBO(90, 157, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Inika',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sudah punya akun ?',
                      style: TextStyle(
                        fontFamily: 'Inika',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
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
                SizedBox(
                  width: maxInputWidth,
                  child: _buildMessageBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}