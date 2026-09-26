import 'package:evently/firebase_utils.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/TOAST_UTILS.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: '');

  var passwordController = TextEditingController(text: '');

  var formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * 0.02,
                children: [
                  Image.asset(
                    themeProvider.isDarkMode(context)
                        ? AppAssets.eventlyDarkS
                        : AppAssets.eventlyLightS,
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginToYourAccount,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  CustomTextField(
                    filled: true,
                    fillColor: Theme
                        .of(context)
                        .highlightColor,
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
                    filled: true,
                    fillColor: Theme
                        .of(context)
                        .highlightColor,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          //todo : nav to forget password screen.
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgetPassword,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Theme
                                .of(context)
                                .dividerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onPressed: login,
                    child: isLoading ? CircularProgressIndicator()
                        :
                    Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAnAccount,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.registerRouteName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
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
                  SizedBox(height: height * 0.01),
                  CustomElevatedButton(
                    borderColor: Theme
                        .of(context)
                        .dividerColor,
                    padding: height * 0.02,
                    onPressed: loginWithGoogle,
                    backgroundColor: Theme
                        .of(context)
                        .highlightColor,
                    child: Row(
                      spacing: width * 0.02,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.google),
                        Text(
                          AppLocalizations.of(context)!.loginWithGoogle,
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

  void login() async {
    {
      if (formKey.currentState!.validate() == true) {
        isLoading = true;
        setState(() {

        });
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          var user = await FirebaseUtils.readUserFromFirestore(
              credential.user?.uid ?? '');
          if (user == null) {
            return;
          }
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.updateUser(user);
          isLoading = false;
          ToastUtils.toastMsg(
            msg: 'Login Success',
            backgroundColor: Theme
                .of(context)
                .cardColor,
            textColor: AppColors.white,
            gravity: ToastGravity.BOTTOM,
          );
          Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-credential') {
            isLoading = false;
            ToastUtils.toastMsg(
              msg: 'the email or password is incorrect',
              backgroundColor: AppColors.red,
              textColor: AppColors.white,
              gravity: ToastGravity.BOTTOM,
            );
          } else if (e.code == 'network-request-failed') {
            isLoading = false;
            ToastUtils.toastMsg(
              msg: 'No internet connection',
              backgroundColor: AppColors.red,
              textColor: AppColors.white,
              gravity: ToastGravity.BOTTOM,
            );
          }
        } catch (e) {
          isLoading = false;
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

  void loginWithGoogle() async {
    isLoading = true;
    setState(() {});
    try {
      final credential = await FirebaseUtils.signInWithGoogle();
      var existingUser = await FirebaseUtils.readUserFromFirestore(
          credential.user?.uid ?? '');

      MyUser myUser;
      if (existingUser == null) {
        myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: credential.user?.displayName ?? '',
          email: credential.user?.email ?? '',
        );
        await FirebaseUtils.addUserToFireStore(myUser);
      } else {
        myUser = existingUser;
      }

      if (!context.mounted) return;
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(myUser);
      isLoading = false;
      setState(() {});
      ToastUtils.toastMsg(
        msg: 'Login Success',
        backgroundColor: Theme
            .of(context)
            .cardColor,
        textColor: AppColors.white,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    } catch (e) {
      isLoading = false;
      setState(() {});
      ToastUtils.toastMsg(
        msg: e.toString(),
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
