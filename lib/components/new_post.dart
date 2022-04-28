import 'package:flutter/material.dart';
import '../../components/custom_text_field.dart';

class NewPost extends StatefulWidget {
  const NewPost({ Key? key }) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
   final commentController = TextEditingController();
   final mediaPathController = TextEditingController();
  late String responseContent;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  
  @override
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a post"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //form
        child: Flexible(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                /* Text(
                  "Form-Validation In Flutter ",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ), */
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                TextFormField(
                  maxLines: 6,
                  decoration: InputDecoration(labelText: 'Write something'),
                  controller: commentController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      //return 'Enter  email!';
                    }
                    return null;
                  },
                ),
                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input 
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  controller:mediaPathController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      //return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  onPressed: () => _submit(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  /* Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           TextField(
                          controller: commentController,
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
                          }),
                          ButtonBar()
                          
        ],
      ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
              onPressed: createPost,
              tooltip: 'Write a new post',
              child: Icon(Icons
                  .send)),
      ) 
    );
  }

  void createPost() {


    //TODO: insert post

  } */
