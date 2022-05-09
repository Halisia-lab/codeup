import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/custom_colors.dart';


class CustomDialog extends StatelessWidget {
  final String assetName;
  final String description;
  final bool linkify;

  const CustomDialog({Key? key, required this.assetName, required this.description, this.linkify = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialogBorderRadius = Platform.isAndroid ? BorderRadius.circular(4) :
      BorderRadius.circular(14);
    const assetHeight = 50.0, horizontalPadding = 16.0, verticalPadding = 20.0;
    final mTheme = Theme.of(context);

    final dialogAsset = Positioned(
      left: horizontalPadding,
      right: horizontalPadding,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: assetHeight/2,
        child: ClipRRect(
          child: Image.asset(assetName, height: assetHeight),
        ),
      ),// top part
    );

    final dismissStr = "Dismiss";

    final dismissButton = TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          Platform.isIOS ? dismissStr : dismissStr.toUpperCase(),
          style: mTheme.textTheme.button?.copyWith(color: CustomColors.mainPurple),
        )
    );

    final textLinkifiableDescription = ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
      child: SingleChildScrollView(
        child: linkify ? Linkify(
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text: description,
          style: mTheme.textTheme.bodyText2,
          linkStyle: mTheme.textTheme.bodyText2?.copyWith(color: Colors.blueAccent, decoration: TextDecoration.underline),
          options: LinkifyOptions(humanize: false),
        ) : Text(
          description,
          style: mTheme.textTheme.bodyText2,
        ),
      ),
    );

    final dialogBox = Container(
      padding: EdgeInsets.only(
        top: assetHeight/2 + verticalPadding,
        right: Platform.isAndroid ? horizontalPadding : 0.0,
        left : Platform.isAndroid ? horizontalPadding : 0.0,
        bottom: verticalPadding/2, //The dialog button has inner padding
      ),
      margin: const EdgeInsets.only(top: assetHeight/2),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Platform.isAndroid ? Colors.white : CustomColors.iosDialogBckg,
        borderRadius: dialogBorderRadius,
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            blurRadius: 4
          ),
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Platform.isAndroid ? textLinkifiableDescription :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: textLinkifiableDescription,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Platform.isAndroid ? Align(
              alignment: Alignment.bottomRight,
              child: Platform.isAndroid ? dismissButton :
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: dismissButton,
                ),
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Divider(color: CustomColors.lightGrey7, thickness: 0.5),
                dismissButton,
              ],
            ),
          ),
        ],
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: dialogBorderRadius,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      //ScrollView is added to avoid keyboard overflow with the dialog while it is being closed
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            dialogBox,
            dialogAsset,
          ],
        ),
      ),
    );
  }
}
