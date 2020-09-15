
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends  StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String userImage;
  final String username;

   MessageBubble(this.message,this.isMe,this.userImage,this.key,this.username);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Row(
        mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe?Colors.grey[300]:Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe?Radius.circular(0):Radius.circular(12),
                bottomRight: isMe?Radius.circular(0):Radius.circular(12),
              ),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
            child: Column(
              crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                 Text(username,
                      style:TextStyle(fontWeight:FontWeight.bold,
                          color: isMe?Colors.black:Theme.of(context).accentTextTheme.title.color,
                      ),
                    ),
                Text(message,
                  textAlign: isMe?TextAlign.end:TextAlign.start,
                  style: TextStyle(
                    color: isMe?Colors.black:Theme.of(context).accentTextTheme.title.color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        Positioned(
          top: 0,
          left:isMe?null: 120,
          right: isMe?120:null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        )
    ],
      overflow: Overflow.visible,
    );

  }
}
