import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _CustomTextFieldState extends State<CustomTextField> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();
  late String responseContent;

@override
void initState() {
  super.initState();
  responseContent = "";

  // Start listening to changes.
}

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            //TODO: replace with currentUser avatar
                            "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png"),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                            hintText: 'Add a reponse...',
                            border: InputBorder.none,
                          ),
                         onChanged: (str) {setState(() {
                              responseContent = str;
                            });},
                          onSubmitted: (str) {
                            
                            final snackBar = SnackBar(
                              content: Text('str'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            /* commentState.addComentToPost(
                                              getModel.key.toString(),
                                              str,
                                              DateTime.now().toString(),
                                              authStateFalse?.userId,
                                              authStateFalse.userModel.displayName,
                                              authStateFalse.userModel.profilePic);

                                          final snackBar = SnackBar(
                                            content: Text('Comment Posted'),
                                            action: SnackBarAction(
                                              textColor: Color(0xff2acfff),
                                              label: 'See Comment',
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Comment(),
                                                    settings: RouteSettings(
                                                        arguments: getModel.key),
                                                  ),
                                                );
                                              },
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
*/
                          }),
                    ),
                    SizedBox(width: 10.0),
                    /* Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: GestureDetector(
                        onTap: responseContent.length> 0 ? sendResponse : null,
                        child: Icon(
                          Icons.send_rounded,
                          size: 25.0,
                          color: responseContent.length> 0 ? Colors.blue : Colors.grey.shade200,
                        ),
                      ),
                    ), */
                    SizedBox(width: 12.0),
                  ],
                );
  }


}
