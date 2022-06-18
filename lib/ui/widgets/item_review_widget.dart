import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/comment_model.dart';


class ItemReviewWidget extends StatelessWidget {
  //const ItemReviewWidget({Key? key}) : super(key: key);

  CommentModel reviewsModel;

  ItemReviewWidget({
    required this.reviewsModel,
  });


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 15,
              backgroundColor: Colors.black12,
              backgroundImage: NetworkImage( reviewsModel != null ? reviewsModel.snippet.topLevelComment.snippet.authorProfileImageUrl :
              "https://images.pexels.com/photos/11482693/pexels-photo-11482693.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              ),
            ),
            const SizedBox(width: 8),
            Text(reviewsModel.snippet.topLevelComment.snippet.authorDisplayName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                )),
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            "${reviewsModel.snippet.topLevelComment.snippet.publishedAt.toString().substring(0, 10)}",
            style: TextStyle(color: Colors.white54, fontSize: 13.0),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Icon(
            Icons.check_outlined,
            color: Colors.white54,
            size: 14.0,
          ),
          Text(
            "${reviewsModel.snippet.topLevelComment.snippet.likeCount.toString()}",
            style: TextStyle(color: Colors.white54, fontSize: 13.0),
          ),
        ],
      ),
      children: [
        Text(
          reviewsModel.snippet.topLevelComment.snippet.textOriginal,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
