import 'package:flutter/material.dart';
import '../Search.dart';
import 'components/post_list.dart';

import 'common/utils.dart';
import 'components/textformfield.dart';
import 'models/Person.dart';
import 'services/AuthenticationService.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<Person>? _futurePerson;

  @override
  Widget build(BuildContext context) {
    return Center(
          child: _futurePerson == null ? buildFormLogin() : buildFutureBuilderLogin(),
        );
  }

  Form buildFormLogin() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: CustomTextFormField(
                controller: _loginController,
                input: "Login",
                isPassword: false,
              ),
            ),
            SizedBox(height: 10), // to add separation between two widgets
            Container(
              child: CustomTextFormField(
                controller: _passwordController,
                input: "Password",
                isPassword: true,
              ),
            ),
            SizedBox(height: 10), // to add separation between two widgets
            ElevatedButton(
              onPressed: onClickSubmitButton,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<Person> buildFutureBuilderLogin() {
    return FutureBuilder<Person>(
      future: _futurePerson,
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if(snapshot.hasError){
              Utils.displayAlertDialog(context, "Error", "Error during the Authentication");
              return buildFormLogin();
            }
            if(!snapshot.hasData){
              Utils.displayAlertDialog(context, "Error", "Person not found");
              return buildFormLogin();
            }
            Utils.displayAlertDialog(context, "Success", "Authentication");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Search()),
            );
            return Text(snapshot.data!.name);
          default:
            return Text("Authentication");
        }
      },
    );
  }

  void onClickSubmitButton() async {
    //verify if form is valid
    if (_formKey.currentState!.validate()) {
      try{
        // Person user = await _authenticationService.login(
        //     _loginController.text.trim(), _passwordController.text.trim());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Search()),
        );
      }catch(err){
        print("Error: $err");
        Utils.displayAlertDialog(context, "Error during the Authentication", err.toString());
      }
    }
  }

  
}
