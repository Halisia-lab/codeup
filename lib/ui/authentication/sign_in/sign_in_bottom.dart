import 'dart:convert';

import 'package:codeup/services/auth_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:codeup/ui/common/test_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../entities/person.dart';
import '../../../entities/post.dart';
import '../../../entities/user.dart';
import '../../../services/secure_storage.dart';
import '../../../utils/sign_in_field_enum.dart';
import '../../common/custom_colors.dart';
import '../../component/adaptive_button.dart';
import '../../home/home_screen.dart';
import '../sign_up/sign_up_screen.dart';
import '../viewModel/sign_in_fields_view_model.dart';
import '../viewModel/soft_keyboard_view_model.dart';

class SignInBottom extends StatefulWidget {
  final BuildContext ancestorContext;
  final AuthService authService;

  const SignInBottom(
      {Key? key, required this.ancestorContext, required this.authService})
      : super(key: key);

  @override
  _SignInBottomState createState() => _SignInBottomState(this.authService);
}

class _SignInBottomState extends State<SignInBottom> {
  final AuthService authService;

  _SignInBottomState(this.authService);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildSignIn(context),
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Row(
              children: [
                Text(
                  "Not registered ? ",
                  style: theme.textTheme.button?.copyWith(
                    color: CustomColors.darkGrey3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: _signUp,
                    child: Text(
                      "Register",
                      style: theme.textTheme.button?.copyWith(
                        color: CustomColors.mainYellow,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ],
            ),
          ),
        ]);
  }

  Widget _buildSignIn(BuildContext context) {
    final signInFieldsProperties =
        Provider.of<SignInFieldsViewModel>(context, listen: false);
    final buttonWidth = MediaQuery.of(context).size.width * 0.5;

    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: buttonWidth,
      child:
          // Consumer<UserAuthenticationViewModel>(
          //   builder: (ctx, userAuthenticationVm, child) {
          //     return

          AdaptiveButton(
        type: ButtonType.primary,
        btnLabel: "Log in",
        btnWidth: buttonWidth,
        btnHandler: () {
          _submitAuthentication(signInFieldsProperties);
        },
        //signInState: userAuthenticationVm.signInState
      ),

      //   }
      // ),
    );
  }

  bool _isFieldNotNullOrEmptyOrBlank(
      SignInFieldEnum signInField, SignInFieldsViewModel signInFieldsVm) {
    final TextEditingController tController =
        (signInField == SignInFieldEnum.email)
            ? signInFieldsVm.tLoginController
            : signInFieldsVm.tPasswordController;
    bool isNotNullOrEmpty = false;

    if (tController.text.isNotEmpty && tController.text.trim().isNotEmpty) {
      isNotNullOrEmpty = true;
      signInFieldsVm.setSignInFieldErrorState(signInField, null);
    } else {
      signInFieldsVm.setSignInFieldErrorState(
          signInField, _getSignInErrorMessage(signInField));
    }

    return isNotNullOrEmpty;
  }

  String? _getSignInErrorMessage(SignInFieldEnum signInField) {
    switch (signInField) {
      case SignInFieldEnum.email:
        return "Empty email";

      case SignInFieldEnum.password:
        return "Empty password";

      default:
        return null;
    }
  }

  bool _validateLoginFields(SignInFieldsViewModel signInFieldsVm) {
    bool res = false;

    res = _isFieldNotNullOrEmptyOrBlank(SignInFieldEnum.email, signInFieldsVm);
    res = _isFieldNotNullOrEmptyOrBlank(
            SignInFieldEnum.password, signInFieldsVm) &&
        res;

    return res;
  }

  void _submitAuthentication(SignInFieldsViewModel signInFieldsVm) async {
    //UserAuthenticationViewModel userAuthenticationVm)
    //Reset sign in error message between between the sign in fields and sign in button
    // userAuthenticationVm.hasSignInFailed = false;

    //Check if the sign in fields are properly filled
    if (_validateLoginFields(signInFieldsVm)) {
      final user = User(-1, "", signInFieldsVm.tPasswordController.text,
          signInFieldsVm.tLoginController.text, "", "");

      http.Response response = await authService.logIn(signInFieldsVm, user);
      if (response.statusCode == 200 || response.statusCode == 201) {
        SecureStorageService.getInstance().set("jwtToken", user.password);
        SecureStorageService.getInstance().set("username", user.username);
        authService.getLoggedUser(user);

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return HomeScreen();
        }));
      } else {
        signInFieldsVm.setSignInFieldErrorState(SignInFieldEnum.email, "");
        signInFieldsVm.setSignInFieldErrorState(SignInFieldEnum.password, "");
      }
      // userAuthenticationVm.signInState = SignInState.processing,
      // userAuthenticationVm.signIn(signInFieldsVm.tLoginController.text,
      //     signInFieldsVm.tPasswordController.text).then((value) {
      //   if (userAuthenticationVm.isSignedIn) {
      //     FocusScope.of(widget.ancestorContext).unfocus(); //Close the soft keyboard
      //

      //   } else if (userAuthenticationVm.hasSignInFailed) {
      //     //Incorrect sign in fields
      //     signInFieldsVm.setSignInFieldErrorState(SignInFieldEnum.username, "");
      //     signInFieldsVm.setSignInFieldErrorState(SignInFieldEnum.password, "");
      //   }
      // })

    }
  }

  void _signUp() {
    final softKeyboardVm =
        Provider.of<SoftKeyboardViewModel>(context, listen: false);

    /* Close the soft keyboard if opened: interactions with the latter
            are not relevant while the dialog is opened */
    softKeyboardVm.isSoftKeyboardOpened = false;

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return SignUpScreen();
    }));
  }
}
