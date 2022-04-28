import 'package:flutter/material.dart';
import '/components/details_post/top_comment.dart';
import '/components/details_post/comment_list.dart';
import '/components/post_content/content_type_enum.dart';
import '/components/post_content/image_viewer.dart';
import '/components/post_content/text_viewer.dart';
import '/components/post_content/video_viewer.dart';
import '/components/votes_counter.dart';
import '/test_data.dart';

import '../person.dart';
import 'details_post/comment.dart';

class Post extends StatefulWidget {
  final Person person;
  final bool certifiate;
  final ContentType contentType;
  final String mediaPath;
  final String date;
  final String text;
  final String description;
  final int votes;
  late Post topComment;
  List<Post> comments;

  Post(this.person, this.certifiate, this.contentType, this.mediaPath, this.date, this.text,
      this.description, this.votes, this.comments);

  @override
  _PostState createState() => _PostState(
      this.person,
      this.certifiate,
      this.contentType,
      this.mediaPath,
      this.date,
      this.text,
      this.description,
      this.votes,
      this.comments);
}

class _PostState extends State<Post> {
  final Person person;
  final bool certifiate;
  final ContentType contentType;
  final String mediaPath;
  final String date;
  final String text;
  final String description;
  late List comments;
  late Post topComment;
  int votes = 0;
  late String responseContent;
  _PostState(this.person, this.certifiate, this.contentType, this.mediaPath, this.date,
      this.text, this.description, this.votes, this.comments);

  //get commentController => null;
 final commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    //comments = TestData.comments;
    responseContent = "";
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // User profile, name and more option
                Row(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          /* Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => Profile(
                                                profileId: snapshot.data()['userId'],
                                              ),
                                          transitionDuration:
                                              Duration(milliseconds: 2000),
                                          transitionsBuilder: (_,
                                              Animation<double> animation,
                                              __,
                                              Widget child) {
                                            return Opacity(
                                              opacity: animation.value,
                                              child: child,
                                            );
                                          })); */
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(this.person.photoUrl),
                              radius: 30),
                        )),
                    InkWell(
                      onTap: () {
                        /* Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => Profile(
                                                profileId: snapshot.data()['userId'] ?? 'unknown userId',
                                              ),
                                          transitionDuration:
                                              Duration(milliseconds: 2000),
                                          transitionsBuilder: (_,
                                              Animation<double> animation,
                                              __,
                                              Widget child) {
                                            return Opacity(
                                              opacity: animation.value,
                                              child: child,
                                            );
                                          })); */
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                //snapshot.data()['displayName'] ?? 'unknown display name',
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  person.name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  this.description,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    /* IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () =>
                            null /* _showMuteDialog(
                                      getContext,
                                      getModel,
                                      isMyPost,
                                      displayname: snapshot.data()['displayName'] ?? 'unknown displayName',
                                      username: snapshot.data()['username'] ?? 'unknown username',
                                      userId: snapshot.data()['userId'] ?? 'unknown userId',
                                    ), */
                        ), */
                  ],
                ),
                //Caption
                Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 16),
                    child: Row(
                      children: [
                        VotesCounter(votes),
                        Expanded(child: TextViewer(this.text)),
                        this.certifiate ? Icon(Icons.check_circle, color: Colors.green,) : Icon(null),
                        
                        ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      this.date,
                      //getChatTime(getModel.createdAt),
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
                // Single or collection of images/videos
                SizedBox(height: 8.0),
                this.contentType == ContentType.TEXT
                    ? Text("")
                    : Container(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          alignment: Alignment.centerRight,
                          child: this.contentType == ContentType.VIDEO
                              ? VideoViewer(mediaPath)
                              : ImageViewer(mediaPath),
                          /* getModel.imagePath == null
                                      ? SizedBox.shrink()
                                      : selectingGrid(imagePath: getModel.imagePath), */
                        ),
                      ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, top: 5, right: 15, left: 15),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentList(this.widget),
                            /* settings:
                                            RouteSettings(arguments: getModel.key), */
                          ),
                        );
                      },
                      child: TopComment(this.widget)),
                ),

                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: 12.0), // For padding
                        SizedBox(width: 12.0), // For padding
                        SizedBox(width: 12.0), // For padding
                        Expanded(child: SizedBox()),
                        //Icon(CustomIcons.bookmark_lineal),
                        SizedBox(width: 10.0), // For padding
                      ],
                    ),
                  ],
                ),
                // People liked information with icon
                //NormalHomeFeedButton(model: getModel),
                SizedBox(height: 4.0),
                // View all comments
                InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10),
                      child: Row(children: [
                        Text(
                          'View all',
                          style: TextStyle(color: Colors.black45),
                        ),
                        Text(
                          ' reponses',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentList(this.widget),
                          /* settings:
                                            RouteSettings(arguments: getModel.key), */
                        ),
                      );
                    }),
                // Add comment section
                Row(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: GestureDetector(
                        onTap: responseContent.length> 0 ? sendResponse : null,
                        child: Icon(
                          Icons.send_rounded,
                          size: 25.0,
                          color: responseContent.length> 0 ? Colors.blue : Colors.grey.shade200,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendResponse() {
    final snackBar = SnackBar(
      content: Text('Response sent'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(commentController.text);
    commentController.clear();
    //TODO insert a new comment
  }
}
