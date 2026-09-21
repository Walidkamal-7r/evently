import 'package:evently/utils/TOAST_UTILS.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'walid');

  var emailController = TextEditingController(text: 'walid@route.com');

  var passwordController = TextEditingController(text: '123456');

  var rePasswordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * 0.02,
                children: [
                  Image.asset(
                    themeProvider.isDarkMode()
                        ? AppAssets.eventlyDarkS
                        : AppAssets.eventlyLightS,
                  ),
                  Text(
                    AppLocalizations.of(context)!.createYourAccount,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: AppColors.disable,
                    ),
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return AppLocalizations.of(context)!.enterYourName;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enterYourEmail,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.disable,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return AppLocalizations.of(context)!.enterYourEmail;
                      }
                      final bool emailValid =
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return AppLocalizations.of(context)!.enterValidEmail;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                    hintText: AppLocalizations.of(context)!.enterYourPassword,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: AppColors.disable,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.disable,
                    ),
                    obscureText: true,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return AppLocalizations.of(context)!.enterYourPassword;
                      }
                      if (text.length < 6) {
                        return AppLocalizations.of(context)!.passNotValid;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                    hintText: AppLocalizations.of(context)!.confirmYourPassword,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: AppColors.disable,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.disable,
                    ),
                    obscureText: true,
                    controller: rePasswordController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return AppLocalizations.of(context)!.enterYourPassword;
                      }
                      if (text != passwordController.text) {
                        return AppLocalizations.of(context)!.passNotMatch;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.001),
                  CustomElevatedButton(
                    onPressed: register,
                    child: Text(
                      AppLocalizations.of(context)!.signUp2,
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAnAccount,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          //todo : nav to register screen.
                          Navigator.of(context)
                              .pushNamed(AppRoutes.loginRouteName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displaySmall,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme
                              .of(context)
                              .dividerColor,
                          thickness: 2,
                          indent: width * 0.03,
                          endIndent: width * 0.03,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme
                              .of(context)
                              .dividerColor,
                          thickness: 2,
                          indent: width * 0.03,
                          endIndent: width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.001),
                  CustomElevatedButton(
                    borderColor: Theme
                        .of(context)
                        .dividerColor,
                    padding: height * 0.02,
                    onPressed: register,
                    backgroundColor: Theme
                        .of(context)
                        .highlightColor,
                    child: Row(
                      spacing: width * 0.02,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.google),
                        Text(
                          AppLocalizations.of(context)!.signUpWithGoogle,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
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
    );
  }

  void register() async {
    {
      if (formKey.currentState!.validate() == true) {
        try {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          ToastUtils.toastMsg(
            msg: 'Account created successfully.',
            backgroundColor: Theme
                .of(context)
                .cardColor,
            textColor: AppColors.white,
            gravity: ToastGravity.BOTTOM,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            ToastUtils.toastMsg(
              msg: 'The password provided is too weak.',
              backgroundColor: AppColors.red,
              textColor: AppColors.white,
              gravity: ToastGravity.BOTTOM,
            );
          } else if (e.code == 'email-already-in-use') {
            ToastUtils.toastMsg(
              msg: 'The account already exists for that email.',
              backgroundColor: AppColors.red,
              textColor: AppColors.white,
              gravity: ToastGravity.BOTTOM,
            );
          }
        } catch (e) {
          ToastUtils.toastMsg(
            msg: e.toString(),
            backgroundColor: AppColors.red,
            textColor: AppColors.white,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
    }
  }
}
