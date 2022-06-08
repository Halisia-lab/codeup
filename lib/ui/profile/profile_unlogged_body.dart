import 'package:codeup/entities/person.dart';
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

class ProfileUnLoggedBody extends StatefulWidget {
  static const routeName = "/profile-screen";

  final bool backOption;
  final Person wantedUser;
  const ProfileUnLoggedBody(this.wantedUser, this.backOption);

  @override
  State<ProfileUnLoggedBody> createState() => _ProfileUnLoggedBodyState(this.wantedUser, this.backOption);
}

class _ProfileUnLoggedBodyState extends State<ProfileUnLoggedBody> {
  final currentUser = TestData.personnes[1];
  final SoftKeyboardViewModel _softKeyboardVm = SoftKeyboardViewModel();
  final SignInFieldsViewModel _signInFieldsVm = SignInFieldsViewModel();
  final background_color = CustomColors.white;
  final Person wantedUser;
  final backOption;

  bool _pwdVisibilityToggled = false;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _firstnameFocusNode = FocusNode();
  FocusNode _lastnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  _ProfileUnLoggedBodyState(this.wantedUser, this.backOption);

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
        backgroundColor: background_color, drawer: !backOption ? const Menu() : null, body: body);
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
        CustomAppBar(wantedUser.user.firstname + " " + wantedUser.user.lastname, false),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(wantedUser.photoUrl, height: 120,),
                  ),
                
                  const Text("Username"),
                  _buildUsername(
                      textFieldHeight),
                  const Text("Firstname"),
                  _buildFirstname(
                      textFieldHeight),
                  const Text("Lastname"),
                  _buildLastname(
                      textFieldHeight),
                  const Text("Email"),
                  _buildEmail(
                      textFieldHeight),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildUsername(
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
          enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: wantedUser.user.username,
              hintStyle: const TextStyle(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFirstname(
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
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: wantedUser.user.firstname,
              hintStyle: const TextStyle(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            
          ),);
        }),
      ),
    );
  }

  Widget _buildLastname(
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
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: wantedUser.user.lastname,
              hintStyle: const TextStyle(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
          ),);
        }),
      ),
    );
  }

  Widget _buildEmail(
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
            enabled: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15.0),
              hintText: wantedUser.user.email,
              hintStyle: const TextStyle(
                color: CustomColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
          ),);
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
