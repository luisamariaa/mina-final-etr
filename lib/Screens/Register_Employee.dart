import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mad_final_project/Screens/LoginScreen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RegisterEmployeeScreen extends StatefulWidget {
  RegisterEmployeeScreen({super.key});

  @override
  State<RegisterEmployeeScreen> createState() => _RegisterEmployeeScreenState();
}

class _RegisterEmployeeScreenState extends State<RegisterEmployeeScreen> {
  final _formkey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final birthDate = TextEditingController();
  final age = TextEditingController();
  final address = TextEditingController();
  final mobileNumber = TextEditingController();
  final education = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = false;
  // @override
  // void initState() {
  //   super.initState();
  //   birthDate = DateTime.now();
  // }

  InputDecoration setTextDecoration(String name, {bool isPassword = false}) {
    return InputDecoration(
      border: OutlineInputBorder(),
      label: Text(
        name,
        style: TextStyle(
            color: Color.fromARGB(255, 60, 3, 107),
            fontWeight: FontWeight.bold),
      ),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: toggleShowPassword,
              icon:
                  Icon(showPassword ? Icons.visibility : Icons.visibility_off),
            )
          : null,
      filled: true,
      fillColor: Color.fromARGB(75, 255, 255, 255),
      contentPadding: const EdgeInsets.only(left: 10.0, bottom: 4.0, top: 4.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        birthDate.text = _picked.toString().split(" ")[0];
      });
    }
  }

  void register() {
    //validate
    if (!_formkey.currentState!.validate()) {
      return;
    }
    //confirm to the user
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      // text: 'sample',
      title: 'Are you sure?',
      confirmBtnText: 'YES',
      cancelBtnText: 'No',
      onConfirmBtnTap: () {
        //register in firebase auth
        Navigator.of(context).pop();
        registerClient();
      },
    );
  }

  void registerClient() async {
    try {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Registering your account',
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      //firestore add document
      String user_id = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(user_id).set({
        'firstname': firstName.text,
        'middlename': middleName.text,
        'lastname': lastName.text,
        'birthdate': birthDate.text,
        'age': age.text,
        'address': address.text,
        'mobileNum': mobileNumber,
        'education': education.text,
        'email': email.text,
        'type': 'employee',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registered successfully!',
              style: TextStyle(fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (ex) {
      Navigator.of(context).pop();
      var errorTitle = '';
      var errorText = '';
      if (ex.code == 'weak-password') {
        errorText = 'Please enter a password with more than 6 characters';
        errorTitle = 'Weak Password';
      } else if (ex.code == 'email-already-in-use') {
        errorText = 'Password is already registered';
        errorTitle = 'Please enter a new email.';
      }

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: errorTitle,
        text: errorText,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: const Color.fromARGB(255, 223, 176, 231),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 60, 3, 107),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create Your',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Account!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Gap(10),
                    TextFormField(
                      controller: firstName,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('First Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: middleName,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Middle Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: lastName,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: birthDate,
                      decoration: InputDecoration(
                        labelText: 'Birth Date',
                        filled: false,
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate();
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: age,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: address,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: mobileNumber,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Mobile Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: education,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Education'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      controller: email,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'please provide a valid email\nEx: wxample@gmail.com';
                        }
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      obscureText: showPassword,
                      controller: password,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration:
                          setTextDecoration('Password', isPassword: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (value.length < 7) {
                          return 'Password should be more than Six(6) characters!';
                        }
                        return null;
                      },
                    ),
                    Gap(8),
                    TextFormField(
                      obscureText: showPassword,
                      controller: confirmPassword,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: setTextDecoration('Confirm Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (value.length < 7) {
                          return 'Password should be more than Six(6) characters!';
                        }
                        if (password.text != value) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                    ),
                    Gap(10),
                    ElevatedButton(
                      onPressed: register,
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
