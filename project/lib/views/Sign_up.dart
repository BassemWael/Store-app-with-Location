// ignore_for_file: unused_field

import 'package:assignment/Person.dart';
import 'package:assignment/boxes.dart';
import 'package:assignment/views/Profile.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const String routeName = "sign_up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int? _level;
  Gender _gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name (Required)",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _name = val!;
                  },
                ),
                const SizedBox(height: 10.0),

                // Gender
                Row(
                  children: [
                    const Text('Gender:'),
                    Radio<Gender>(
                      value: Gender.male,
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    const Text('Male'),
                    const SizedBox(width: 10.0),
                    Radio<Gender>(
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    const Text('Female'),
                  ],
                ),
                const SizedBox(height: 10.0),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText:
                        "Email (FCI format: studentID@stud.fci-cu.edu.eg - Required)",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[\w.-]+@stud\.fci-cu\.edu\.eg$")
                        .hasMatch(value)) {
                      return 'Invalid FCI email format';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _email = val!;
                  },
                ),
                const SizedBox(height: 10.0),

                // Student ID
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: "Student ID (Required)",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your student ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),

                // Level
                DropdownButtonFormField<int>(
                  value: _level,
                  hint: const Text('Select Level (Optional)'),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('1')),
                    DropdownMenuItem(value: 2, child: Text('2')),
                    DropdownMenuItem(value: 3, child: Text('3')),
                    DropdownMenuItem(value: 4, child: Text('4')),
                  ],
                  onChanged: (value) => setState(() => _level = value!),
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: _passwordController, // Use the controller
                  decoration: const InputDecoration(
                    labelText: "Password (Min. 8 characters - Required)",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: _confirmPasswordController, // Use the controller
                  decoration: const InputDecoration(
                    labelText:
                        "Confirm Password (Must match password - Required)",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value.trim() !=
                        _passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        boxPersons.put(
                            'key_${_emailController.text}',
                            Person(
                                email: _emailController.text,
                                password: _passwordController.text));
                      });
                      Navigator.pushReplacementNamed(
                          context, Profile.routeName);
                    }
                  },
                  child: const Text('Signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
