// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/Utils/utils.dart';
import '/auth/forgot_password_page.dart';
import '/main.dart';
import '../firebase.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  static bool _passwordVisible = false;
  static bool visible = false;
  static bool gvisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    visible = false;
    gvisible = false;
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        key: _formKey,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Text(
                'Hey You, \n Welcome Back',
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                    fontSize: 40,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Container(
                width: 200,
                height: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset('assets/images/auth.png'),
              ),
            ),
            Padding(
              //! EMAIL FIELD
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail_outline_rounded,
                      color: Colors.white70,
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    labelStyle: GoogleFonts.workSans(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    hintStyle: GoogleFonts.workSans(
                      color: Colors.white54,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    labelText: 'Email',
                    hintText: ''),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              //! PASSWORD FIELD
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
              child: TextField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white70,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      }),
                  filled: true,
                  fillColor: Colors.black12,
                  labelStyle: GoogleFonts.workSans(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  hintStyle: GoogleFonts.workSans(
                    color: Colors.white54,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  labelText: 'Password',
                  hintText: '',
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            ElevatedButton.icon(
              onPressed: signIn,
              icon: const Icon(Icons.lock_open, size: 32),
              label: Text(
                'Sign In',
                style: GoogleFonts.workSans(fontSize: 24),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.workSans(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 20,
                ),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: GoogleFonts.workSans(color: Colors.white),
                text: 'No Account? ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Sign Up',
                    style: GoogleFonts.workSans(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.onError),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              width: 300,
              child: TextButton(
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ForgotPasswordPage(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Forgot Password?',
                    style:
                        GoogleFonts.workSans(fontSize: 12, color: Colors.white),
                  )),
            ),
            Container(
              height: 60,
              width: 350,
              padding: const EdgeInsets.only(top: 10),
              // decoration: BoxDecoration(
              //     color: Colors.deepPurple[900],
              //     borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    gvisible = load(gvisible);
                  });
                  googleSignIn(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: <Widget>[
                      const Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 55),
                        child: Text(
                          'Sign in with Google',
                          style: GoogleFonts.workSans(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.transparent,
                            letterSpacing: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.black45,
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  shadowColor: Colors.black45,
                  elevation: 8,
                  //side: BorderSide(color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.white70,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          for (final providerProfile in user.providerData) {
            // ID of the provider (google.com, apple.cpm, etc.)
            final provider = providerProfile.providerId;

            // UID specific to the provider
            final uid = providerProfile.uid;

            // Name, email address, and profile photo URL
            final name = providerProfile.displayName;
            final emailAddress = providerProfile.email;
            final profilePhoto = providerProfile.photoURL;
          }
        }
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      updateUser.updateDisplayName(updateUser);
      userSetup(_usernameController.text);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User currentuser =
          (await auth.signInWithCredential(credential)).user;
      if (currentuser != null) {
        dbRef.child(currentuser.uid);
        Map userDataMap = {
          'name': currentuser.displayName,
          'email': currentuser.email,
        };
        dbRef.child(currentuser.uid).set(userDataMap);

        _formKey.currentState.save();

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        });
        Utils.showSnackBar('Account Created');
      } else {
        setState(() {
          gvisible = load(gvisible);
        });
        Utils.showSnackBar('Account has not been created');
      }
    } catch (e) {
      setState(() {
        gvisible = load(gvisible);
      });
      Utils.showSnackBar(e.message);
    }
  }

  bool load(visible) {
    return visible = !visible;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
