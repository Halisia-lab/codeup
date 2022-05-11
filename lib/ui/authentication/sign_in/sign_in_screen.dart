import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/authentication/sign_in/sign_in_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../menu/menu.dart';
import 'sign_in_body.dart';
import '../viewModel/sign_in_fields_view_model.dart';
import '../viewModel/soft_keyboard_view_model.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SoftKeyboardViewModel _softKeyboardVm = SoftKeyboardViewModel();
  final SignInFieldsViewModel _signInFieldsVm = SignInFieldsViewModel();

  @override
  Widget build(BuildContext context) {
  final AuthService authService = AuthService(signInFieldsVm: _signInFieldsVm);

    final navBarTitle = Text("Sign In", textAlign: TextAlign.center);
    final appBar = AppBar(
      title: Center(
        child: navBarTitle,
      ),
    );
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
        return _getBody(false, authService);
      }),
    ));
    return Scaffold(
      drawer: const Menu(),
      appBar: appBar,
      body: body,
    );
  }

  Widget _getBody(bool isSoftKeyboardOpened, AuthService authService) {
    Widget res;

    const padding1 = 30.0; //left, right, bottom
    const padding2 = 16.0; //top

    final signInScrollView = CustomScrollView(
      slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: padding1,
                right: padding1,
                top: padding2,
                bottom: padding1,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Image.asset("assets/images/mainLogo/codeup_logo.png"),
                  ),
                  const SignInBody(),
                  Flexible(
                    child: Container(), //Empty widget
                  ), //Empty widget
                  SignInBottom(ancestorContext: context, authService: authService,)
                ],
              ),
            ))
      ],
    );

    res = signInScrollView;
    return res;
  }
}
