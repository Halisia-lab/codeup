import 'package:codeup/entities/Person.dart';
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
  final Person wantedUser;
  const ProfileScreen(this.wantedUser);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(this.wantedUser);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = TestData.personnes[1];
  final Person wantedUser;
  final SoftKeyboardViewModel _softKeyboardVm = SoftKeyboardViewModel();
  final SignInFieldsViewModel _signInFieldsVm = SignInFieldsViewModel();
  final background_color = CustomColors.white;

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
        return this.wantedUser == this.currentUser ? ProfileLoggedBody() : ProfileUnLoggedBody(this.wantedUser);
      }),
    ));
    return Scaffold(
        backgroundColor: background_color, drawer: const Menu(), body: body);
  }
}
