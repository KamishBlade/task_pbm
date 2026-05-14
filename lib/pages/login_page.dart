import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    bool success = await ApiService.login(
      usernameController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Login gagal',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0D0D0D),
              Color(0xff1A1A1A),
              Color(0xff2B0000),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                padding:
                    const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color:
                      const Color(0xff151515),
                  borderRadius:
                      BorderRadius.circular(
                    25,
                  ),
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent
                          .withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(
                        15,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent
                            .withOpacity(0.15),
                      ),
                      child: const Icon(
                        Icons.laptop_mac,
                        size: 80,
                        color: Colors.redAccent,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'SELAMAT DATANG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller:
                          usernameController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:
                          InputDecoration(
                        labelText: 'USERNAME',
                        labelStyle:
                            const TextStyle(
                          color:
                              Colors.white70,
                        ),
                        prefixIcon:
                            const Icon(
                          Icons.person,
                          color:
                              Colors.redAccent,
                        ),
                        filled: true,
                        fillColor:
                            Colors.black26,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            15,
                          ),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:
                          InputDecoration(
                        labelText:
                            'Password',
                        labelStyle:
                            const TextStyle(
                          color:
                              Colors.white70,
                        ),
                        prefixIcon:
                            const Icon(
                          Icons.lock,
                          color:
                              Colors.redAccent,
                        ),
                        filled: true,
                        fillColor:
                            Colors.black26,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            15,
                          ),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width:
                          double.infinity,
                      height: 55,
                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              Colors
                                  .redAccent,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              15,
                            ),
                          ),
                        ),
                        onPressed:
                            isLoading
                                ? null
                                : login,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors
                                    .white,
                              )
                            : const Text(
                                'LOGIN ',
                                style:
                                    TextStyle(
                                  color: Colors
                                      .white,
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  letterSpacing:
                                      1,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      '242410103091 INI BUAT NIM NYA GAK TAU KENAPA DITARUH SINI',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}