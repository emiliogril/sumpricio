import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papas/theme.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //! configuracion para boton login y password
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  //! Autetication Password
  //! configuracion formKey

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading = true;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Ninguna usuario encontrada para ese correo electrónico.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Se proporcionó una contraseña incorrecta para ese usuario.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButtonColor,
        centerTitle: true,
        title: const Text('Inicia Sesión'),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [g1, g2],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.030),
            child: Form(
              key: _formKey,
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                overflowSpacing: size.height * 0.014,
                children: [
                  //! la image de logo para cambiar la imagen hay que modificar la ruta "theme.dart"
                  Image.asset(image1),

                  //! Agregar el titulo
                  Text(
                    'Bienvenido',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: kWhiteColor.withOpacity(0.7),
                    ),
                  ),

                  //! Subtitulo
                  const Text(
                    'Simpricio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: kWhiteColor,
                    ),
                  ),

                  //! Espacio para Email

                  SizedBox(height: size.height * 0.030),
                  Column(
                    children: [
                      TextFormField(
                        //! Espacio para configurar firebase
                        controller: _email,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'El correo electrónico está vacío';
                          }
                          return null;
                        },

                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: kInputColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 25.0),
                          filled: true,
                          labelText: 'Email',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(userIcon),
                          ),
                          fillColor: kWhiteColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(37),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //! Espacio para Password

                  TextFormField(
                    //! Espacio para configurar firebase
                    controller: _password,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'La contraseña está vacía';
                      }
                      return null;
                    },

                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: kInputColor,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 25.0),
                      filled: true,
                      labelText: 'Password',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(keyIcon),
                      ),
                      fillColor: kWhiteColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),

                  //! Boton Inicia sesion

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Inicia Sesión',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    onPressed: () {
                      //! configuracion formKey
                      if (_formKey.currentState!.validate()) {
                        signInWithEmailAndPassword();
                      }
                    },
                  ),

                  //! Boton para registrar

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: const Text(
                        'Registraste',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: widget.onPressed,
                  ),

                  //! Espacio en el medio imagen

                  SizedBox(height: size.height * 0.014),
                  SvgPicture.asset('assets/icons/deisgn.svg'),
                  SizedBox(height: size.height * 0.014),

                  //! Boton Inicia sesion Google

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.080,
                      decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: const Text(
                        'Inicia Sesión en Google',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
