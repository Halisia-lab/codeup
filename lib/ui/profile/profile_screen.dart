import 'package:codeup/entities/person.dart';
import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/common/custom_button.dart';
import 'package:codeup/ui/common/test_data.dart';
import 'package:codeup/ui/profile/profile_logged_body.dart';
import 'package:codeup/ui/profile/profile_unlogged_body.dart';
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

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile-screen";
  final bool backOption;
  final Person wantedUser;
  const ProfileScreen(this.wantedUser, this.backOption);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(this.wantedUser);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = AuthService.currentUser;
  final Person wantedUser;
  final SoftKeyboardViewModel _softKeyboardVm = SoftKeyboardViewModel();
  final SignInFieldsViewModel _signInFieldsVm = SignInFieldsViewModel();
  final background_color = CustomColors.lightGrey3;

  bool _pwdVisibilityToggled = false;
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _firstnameFocusNode = FocusNode();
  FocusNode _lastnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  _ProfileScreenState(this.wantedUser);

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
        return this.wantedUser == this.currentUser ? ProfileLoggedBody(widget.backOption) : ProfileUnLoggedBody(this.wantedUser, widget.backOption);
      }),
    ));
    return Scaffold(
        backgroundColor: background_color, drawer: const Menu(), body: body);
  }
}
