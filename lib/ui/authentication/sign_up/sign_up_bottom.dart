import 'package:codeup/backend/model/user_list.dart';
import 'package:codeup/ui/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../backend/http_service.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/custom_dialog.dart';
import '../../../utils/sign_in_field_enum.dart';
import '../../component/adaptive_button.dart';
import '../../home/home_screen.dart';
import '../viewModel/sign_in_fields_view_model.dart';
import '../viewModel/soft_keyboard_view_model.dart';

class SignUpBottom extends StatefulWidget {
   final BuildContext ancestorContext;

  const SignUpBottom({Key? key, required this.ancestorContext}) : super(key: key);

  @override
  _SignUpBottomState createState() => _SignUpBottomState();
}

class _SignUpBottomState extends State<SignUpBottom> {
  String? _appVersion;

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        _buildSignIn(context),
        Padding(
          padding: const EdgeInsets.only(left:80.0),
          child: Row(
            children: [
              Text(
                  "Already have an account ? ",
                  style: theme.textTheme.button?.copyWith(
                      color: CustomColors.darkGrey,
                      fontWeight: FontWeight.bold,
                  ),
              ),TextButton(
                onPressed: _logIn,
                child: Text(
                  "Log in",
                  style: theme.textTheme.button?.copyWith(
                      color: CustomColors.mainYellow,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                  ),
                )
              ),
            ],
          ),
        ),
      ]
    );
  }

  Widget _buildSignIn(BuildContext context) {
    final signInFieldsProperties = Provider.of<SignInFieldsViewModel>(context, listen: false);
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
                btnLabel: "Create an account",
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

  bool _isFieldNotNullOrEmptyOrBlank(SignUpFieldEnum signInField, SignInFieldsViewModel signInFieldsVm) {
    final TextEditingController tController = (signInField == SignInFieldEnum.email) ?
    signInFieldsVm.tLoginController : signInFieldsVm.tPasswordController;
    bool isNotNullOrEmpty = false;

    if (tController.text.isNotEmpty && tController.text.trim().isNotEmpty) {
      isNotNullOrEmpty = true;
      signInFieldsVm.setSignUpFieldErrorState(signInField, null);

    } else {
      signInFieldsVm.setSignUpFieldErrorState(signInField, _getSignUpErrorMessage(signInField));
    }

    return isNotNullOrEmpty;
  }

  String? _getSignUpErrorMessage(SignUpFieldEnum signInField) {
    switch (signInField) {
      case SignUpFieldEnum.firstname:
        return "Empty firstname";

      case SignUpFieldEnum.lastname:
        return "Empty lastname";

      case SignUpFieldEnum.email:
        return "Empty email";

      case SignUpFieldEnum.password:
        return "Empty password";

      default:
        return null;
    }
  }

  bool _validateLoginFields(SignInFieldsViewModel signInFieldsVm) {
    bool res = false;

    res = _isFieldNotNullOrEmptyOrBlank(SignUpFieldEnum.email, signInFieldsVm);
    res = _isFieldNotNullOrEmptyOrBlank(SignUpFieldEnum.password, signInFieldsVm) && res;

    return res;
  }

  void _submitAuthentication(SignInFieldsViewModel signInFieldsVm){
    
      //UserAuthenticationViewModel userAuthenticationVm) 
    //Reset sign in error message between between the sign in fields and sign in button
   // userAuthenticationVm.hasSignInFailed = false;

    //Check if the sign in fields are properly filled
    if (_validateLoginFields(signInFieldsVm)) {
          // userAuthenticationVm.signInState = SignInState.processing,
          // userAuthenticationVm.signIn(signInFieldsVm.tLoginController.text,
          //     signInFieldsVm.tPasswordController.text).then((value) {
          //   if (userAuthenticationVm.isSignedIn) {
          //     FocusScope.of(widget.ancestorContext).unfocus(); //Close the soft keyboard
           Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
             /*  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen())); */

          //   } else if (userAuthenticationVm.hasSignInFailed) {
          //     //Incorrect sign in fields
          //     signInFieldsVm.setSignInFieldErrorState(SignInFieldEnum.username, "");
          //     signInFieldsVm.setSignInFieldErrorState(SignInFieldEnum.password, "");
          //   }
          // })
        
      
    }
  }

 void _logIn() {
    final softKeyboardVm = Provider.of<SoftKeyboardViewModel>(context, listen: false);
    softKeyboardVm.isSoftKeyboardOpened = false;


    //Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)  { return SignInScreen();}));
  }

}