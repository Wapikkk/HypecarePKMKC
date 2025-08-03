import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isPasswordVisible = false;

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
                const SizedBox(height: 50),
                Image.asset(
                  'assets/image/doctor-vector.png',
                  height: 200,
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
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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

                
              ],
            ), 
          ),
        ),
      ),
    );
  }
}