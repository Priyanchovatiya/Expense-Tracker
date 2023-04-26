import 'package:expensetracker/InitialScreens/home_screen.dart';
import 'package:expensetracker/controller/sign_in_control.dart';
import 'package:expensetracker/customs/custome_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:expensetracker/InitialScreens/sign_up.dart';
import 'package:provider/provider.dart';

import '../customs/custom_text.dart';

class LoginpageWidget extends StatefulWidget {
  const LoginpageWidget({Key? key}) : super(key: key);

  @override
  _LoginpageWidgetState createState() => _LoginpageWidgetState();
}

class _LoginpageWidgetState extends State<LoginpageWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  void moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      try {
        setState(() {
          loading = true;
        });
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          setState(() {
            loading = false;
          });
        });
        print(emailController.text);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            loading = false;
            Fluttertoast.showToast(msg: "User Not Found");
          });
        } else if (e.code == 'wrong-password') {
          setState(() {
            loading = false;
            Fluttertoast.showToast(msg: "Password is incorrect!! Try Again");
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: const BoxDecoration(
                  // color: const Color(0xFFE1EBF1),
                  gradient: LinearGradient(
                    colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
                    // [Color(0xFFF3A02C), Color(0xFFE12361)],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0.87, -1),
                    end: AlignmentDirectional(-0.87, 1),
                  ),
                ),
                alignment: const AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 70, 0, 32),
                          child: Container(
                            width: 250,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: const CustomText(
                              text: 'Expense Tracker',
                              size: 31,
                              colour: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 16, 16, 16),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    32, 32, 32, 32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CustomText(
                                      text: 'Welcome Back',
                                      size: 36,
                                      colour: Color(0xFF101213),
                                      fontWeight: FontWeight.w600,
                                    ),

                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    CustomFormField(
                                      textEditingController: emailController,
                                      obsecure: false,
                                      label: 'Email',
                                      hint: 'Enter Email',
                                      validator: (value) {},
                                      onTap: () {},
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: passwordController,
                                          autofocus: true,

                                          obscureText:
                                              passwordVisible ? false : true,
                                          decoration: InputDecoration(
                                            hintText: "Enter Password",
                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: const Color(0xFF57636C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFF4B39EF),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF1F4F8),
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                () => passwordVisible =
                                                    !passwordVisible,
                                              ),
                                              focusNode: FocusNode(
                                                  skipTraversal: true),
                                              child: Icon(
                                                passwordVisible
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: Color(0xFF57636C),
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          // validator: _model
                                          //     .passwordControllerValidator
                                          //     .asValidator(context),
                                        ),
                                      ),
                                    ),

                                    loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 16),
                                            child: InkWell(
                                              onTap: () {
                                                moveToHome(context);
                                                // final provider = Provider.of<
                                                //         GoogleSingInProivder>(
                                                //     context,
                                                //     listen: false);
                                                // provider.GooogleLogIn();
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF4B39EF),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Center(
                                                  child: CustomText(
                                                    text: 'Log in',
                                                    size: 16,
                                                    colour: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 24),
                                      child: CustomText(
                                        text: 'Or sign up with',
                                        size: 16,
                                        colour: Color(0xFF57636C),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 16),
                                        child: InkWell(
                                          onTap: (){
                                            final provider = Provider.of<
                                                        GoogleSingInProivder>(
                                                    context,
                                                    listen: false);
                                                provider.GooogleLogIn();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 44,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: const Border(
                                                  top: BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  bottom: BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  left: BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  right: BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: const [
                                                Icon(
                                                  FontAwesomeIcons.google,
                                                  size: 20,
                                                ),
                                                Center(
                                                  child: CustomText(
                                                    text:
                                                        'Continue With Google',
                                                    size: 16,
                                                    colour: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),

                                    // You will have to add an action on this rich text to go to your login page.
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CustomText(
                                            text: 'Don\'t have an account?  ',
                                            size: 14,
                                            colour: Color(0xFF101213),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignUppageWidget()));
                                            },
                                            child: const CustomText(
                                              text: 'Sign Up here ',
                                              size: 14,
                                              colour: Color(0xFF4B39EF),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
