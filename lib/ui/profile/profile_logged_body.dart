import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/common/custom_button.dart';
import 'package:codeup/ui/common/test_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/sign_in_field_enum.dart';
import '../authentication/viewModel/sign_in_fields_view_model.dart';
import '../authentication/viewModel/soft_keyboard_view_model.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../home/home_screen.dart';
import '../menu/menu.dart';
import '../../../utils/extensions.dart';

class ProfileLoggedBody extends StatefulWidget {
  static const routeName = "/profile-screen";
  const ProfileLoggedBody({Key? key}) : super(key: key);

  @override
  State<ProfileLoggedBody> createState() => _ProfileLoggedBodyState();
}

class _ProfileLoggedBodyState extends State<ProfileLoggedBody> {
  final currentUser = AuthService.currentUser;
  final SoftKeyboardViewModel _softKeyboardVm = SoftKeyboardViewModel();
  final SignInFieldsViewModel _signInFieldsVm = SignInFieldsViewModel();
  final background_color = CustomColors.white;

  bool _pwdVisibilityToggled = false;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _firstnameFocusNode = FocusNode();
  FocusNode _lastnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _firstnameFocusNode.dispose();
    _lastnameFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInFieldsViewModel>(
            create: (_) => _signInFieldsVm),
        ChangeNotifierProvider<SoftKeyboardViewModel>(
            create: (_) => _softKeyboardVm),
      ],
      child: Consumer<SoftKeyboardViewModel>(
          builder: (context, softKeyBoardVm, child) {
        return _getBody();
      }),
    ));
    return Scaffold(
        backgroundColor: background_color, drawer: const Menu(), body: body);
  }

  Widget _getBody() {
    const textFieldHeight = 50.0;
    final inputTextStyle = Theme.of(context).textTheme.bodyText1!;

    const InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );

    const InputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: CustomColors.defaultGrey),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );

    const InputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );

    InputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).primaryColor,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    );

    InputBorder focusedBorderError = const OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.redAccent,
      ),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
    return CustomScrollView(
      slivers: [
        const CustomAppBar("My Profile", false),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(currentUser!.photoUrl, height: 120,),
                  ),
                
                  const Text("Username"),
                  _buildUsername(
                      context,
                      inputTextStyle,
                      border,
                      enabledBorder,
                      errorBorder,
                      focusedBorder,
                      focusedBorderError,
                      textFieldHeight),
                  const Text("Firstname"),
                  _buildFirstname(
                      context,
                      inputTextStyle,
                      border,
                      enabledBorder,
                      errorBorder,
                      focusedBorder,
                      focusedBorderError,
                      textFieldHeight),
                  const Text("Lastname"),
                  _buildLastname(
                      context,
                      inputTextStyle,
                      border,
                      enabledBorder,
                      errorBorder,
                      focusedBorder,
                      focusedBorderError,
                      textFieldHeight),
                  const Text("Email"),
                  _buildEmail(
                      context,
                      inputTextStyle,
                      border,
                      enabledBorder,
                      errorBorder,
                      focusedBorder,
                      focusedBorderError,
                      textFieldHeight),
                  CustomButton(CustomColors.mainYellow, "Update my account",
                      () => _updateProfile())
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildUsername(
      BuildContext context,
      TextStyle inputTextStyle,
      InputBorder mBorder,
      InputBorder mEnabledBorder,
      InputBorder mErrorBorder,
      InputBorder mFocusedBorder,
      InputBorder mFocusedBorderError,
      double textFieldHeight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: textFieldHeight,
      child: Material(
        //Necessary when rendered in a Cupertino widget
        child: Consumer2<SignInFieldsViewModel, SoftKeyboardViewModel>(
            builder: (ctx, signInFieldsVm, softKeyboardVm, child) {
          _updateSignInFocusNodes(signInFieldsVm);
          return TextField(
            showCursor:
                signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.username],
            readOnly: !softKeyboardVm.isSoftKeyboardOpened,
            focusNode: _usernameFocusNode,
            style: inputTextStyle,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, false, false, false, false),
              signInFieldsVm.showPwdCursor = true,
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: currentUser!.user.username,
              hintStyle: GoogleFonts.notoSans(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              errorText: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.username)
                      .isNullOrEmpty()
                  ? null
                  : signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.username),
              border: mBorder,
              enabledBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.username)
                      .isEmptyNonNull()
                  ? mErrorBorder
                  : mEnabledBorder,
              errorBorder: mErrorBorder,
              focusedBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.username)
                      .isEmptyNonNull()
                  ? mFocusedBorderError
                  : mFocusedBorder,
            ),
            controller: signInFieldsVm.tUsernameController,
            onTap: () {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  true, false, false, false, false);
              signInFieldsVm.showPwdCursor = false;

              if (!softKeyboardVm.isSoftKeyboardOpened)
                softKeyboardVm.isSoftKeyboardOpened = true;
            },
          );
        }),
      ),
    );
  }

  Widget _buildFirstname(
      BuildContext context,
      TextStyle inputTextStyle,
      InputBorder mBorder,
      InputBorder mEnabledBorder,
      InputBorder mErrorBorder,
      InputBorder mFocusedBorder,
      InputBorder mFocusedBorderError,
      double textFieldHeight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: textFieldHeight,
      child: Material(
        //Necessary when rendered in a Cupertino widget
        child: Consumer2<SignInFieldsViewModel, SoftKeyboardViewModel>(
            builder: (ctx, signInFieldsVm, softKeyboardVm, child) {
          _updateSignInFocusNodes(signInFieldsVm);
          return TextField(
            showCursor:
                signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.firstname],
            readOnly: !softKeyboardVm.isSoftKeyboardOpened,
            focusNode: _firstnameFocusNode,
            style: inputTextStyle,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, false, false, false, false),
              signInFieldsVm.showPwdCursor = true,
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: currentUser!.user.firstname,
              hintStyle: GoogleFonts.notoSans(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              errorText: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.firstname)
                      .isNullOrEmpty()
                  ? null
                  : signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.firstname),
              border: mBorder,
              enabledBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.firstname)
                      .isEmptyNonNull()
                  ? mErrorBorder
                  : mEnabledBorder,
              errorBorder: mErrorBorder,
              focusedBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.firstname)
                      .isEmptyNonNull()
                  ? mFocusedBorderError
                  : mFocusedBorder,
            ),
            controller: signInFieldsVm.tFirstnameController,
            onTap: () {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, true, false, false, false);
              signInFieldsVm.showPwdCursor = false;

              if (!softKeyboardVm.isSoftKeyboardOpened)
                softKeyboardVm.isSoftKeyboardOpened = true;
            },
          );
        }),
      ),
    );
  }

  Widget _buildLastname(
      BuildContext context,
      TextStyle inputTextStyle,
      InputBorder mBorder,
      InputBorder mEnabledBorder,
      InputBorder mErrorBorder,
      InputBorder mFocusedBorder,
      InputBorder mFocusedBorderError,
      double textFieldHeight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: textFieldHeight,
      child: Material(
        //Necessary when rendered in a Cupertino widget
        child: Consumer2<SignInFieldsViewModel, SoftKeyboardViewModel>(
            builder: (ctx, signInFieldsVm, softKeyboardVm, child) {
          _updateSignInFocusNodes(signInFieldsVm);
          return TextField(
            showCursor:
                signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.lastname],
            readOnly: !softKeyboardVm.isSoftKeyboardOpened,
            focusNode: _lastnameFocusNode,
            style: inputTextStyle,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, false, false, false, false),
              signInFieldsVm.showPwdCursor = true,
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: currentUser!.user.lastname,
              hintStyle: GoogleFonts.notoSans(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              errorText: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.lastname)
                      .isNullOrEmpty()
                  ? null
                  : signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.lastname),
              border: mBorder,
              enabledBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.lastname)
                      .isEmptyNonNull()
                  ? mErrorBorder
                  : mEnabledBorder,
              errorBorder: mErrorBorder,
              focusedBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.lastname)
                      .isEmptyNonNull()
                  ? mFocusedBorderError
                  : mFocusedBorder,
            ),
            controller: signInFieldsVm.tLastnameController,
            onTap: () {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, false, true, false, false);
              signInFieldsVm.showPwdCursor = false;

              if (!softKeyboardVm.isSoftKeyboardOpened)
                softKeyboardVm.isSoftKeyboardOpened = true;
            },
          );
        }),
      ),
    );
  }

  Widget _buildEmail(
      BuildContext context,
      TextStyle inputTextStyle,
      InputBorder mBorder,
      InputBorder mEnabledBorder,
      InputBorder mErrorBorder,
      InputBorder mFocusedBorder,
      InputBorder mFocusedBorderError,
      double textFieldHeight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: textFieldHeight,
      child: Material(
        //Necessary when rendered in a Cupertino widget
        child: Consumer2<SignInFieldsViewModel, SoftKeyboardViewModel>(
            builder: (ctx, signInFieldsVm, softKeyboardVm, child) {
          _updateSignInFocusNodes(signInFieldsVm);
          return TextField(
            showCursor:
                signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.email],
            readOnly: !softKeyboardVm.isSoftKeyboardOpened,
            focusNode: _emailFocusNode,
            style: inputTextStyle,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, false, false, false, false),
              signInFieldsVm.showPwdCursor = true,
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: currentUser!.user.email,
              hintStyle: GoogleFonts.notoSans(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              errorText: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.email)
                      .isNullOrEmpty()
                  ? null
                  : signInFieldsVm.getSignUpFieldError(SignUpFieldEnum.email),
              border: mBorder,
              enabledBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.email)
                      .isEmptyNonNull()
                  ? mErrorBorder
                  : mEnabledBorder,
              errorBorder: mErrorBorder,
              focusedBorder: signInFieldsVm
                      .getSignUpFieldError(SignUpFieldEnum.email)
                      .isEmptyNonNull()
                  ? mFocusedBorderError
                  : mFocusedBorder,
            ),
            controller: signInFieldsVm.tLoginController,
            onTap: () {
              signInFieldsVm.updateMapSignUpFieldsFocus(
                  false, false, false, true, false);
              signInFieldsVm.showPwdCursor = false;

              if (!softKeyboardVm.isSoftKeyboardOpened)
                softKeyboardVm.isSoftKeyboardOpened = true;
            },
          );
        }),
      ),
    );
  }

  void _updateSignInFocusNodes(SignInFieldsViewModel signInFieldsVm) {
    if (signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.email] != null &&
        signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.email]!) {
      _emailFocusNode.requestFocus();
    } else if (signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.firstname] !=
            null &&
        signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.firstname]!) {
      _firstnameFocusNode.requestFocus();
    } else if (signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.username] !=
            null &&
        signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.username]!) {
      _firstnameFocusNode.requestFocus();
    } else if (signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.lastname] !=
            null &&
        signInFieldsVm.mapSignInFieldFocus[SignUpFieldEnum.lastname]!) {
      _lastnameFocusNode.requestFocus();
    }
  }

  _updateProfile() {
  Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}
