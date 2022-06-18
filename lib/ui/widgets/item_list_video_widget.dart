import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/channel_model.dart';
import 'package:flutter_codigo5_youapp/models/video_model.dart';
import 'package:flutter_codigo5_youapp/pages/video_detail_page.dart';
import 'package:flutter_codigo5_youapp/services/api_service.dart';

class ItemListVideoWidget extends StatefulWidget {

  VideoModel videoModel;
  ItemListVideoWidget({required this.videoModel,});

  @override
  State<ItemListVideoWidget> createState() => _ItemListVideoWidgetState();
}

class _ItemListVideoWidgetState extends State<ItemListVideoWidget> {
  final APIService _apiService = APIService();

  getStatistics()async{

    print("El videoId es: ${widget.videoModel.id.videoId}");
    Map<String, dynamic>? mapVideoStatistics = await _apiService.getVideoStatistics(widget.videoModel.id.videoId);
    if (mapVideoStatistics != null){
      //videoModel
      widget.videoModel.viewCount = int.parse(mapVideoStatistics["viewCount"].toString());
      widget.videoModel.likeCount = int.parse(mapVideoStatistics["likeCount"].toString());
      widget.videoModel.favoriteCount = int.parse(mapVideoStatistics["favoriteCount"].toString());
      widget.videoModel.commentCount = int.parse(mapVideoStatistics["commentCount"].toString());
      print(widget.videoModel.viewCount);
      print(mapVideoStatistics["viewCount"]);
      print("getStatistics esto  se esta ejecutando");
      setState(() {

      });
    }else{
      print("getStatistics esto no se esta ejecutando");
    }
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getStatistics();
    print("ejecutando getStatistics");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        print(" videoId desde ItemListVideoWidget: ${widget.videoModel.id.videoId}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoDetailPage(videoModel: widget.videoModel,)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.videoModel.snippet.thumbnails.high.url,
                  width: double.infinity,
                  height: height * 0.3,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7)
                    ),
                    child: Text(
                      "23:02",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: FutureBuilder(
                future: _apiService.getChannel(widget.videoModel.snippet.channelId),
                builder: (BuildContext context, AsyncSnapshot snap){
                  if(snap.hasData){
                    ChannelModel channel = snap.data;
                    return Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white30,
                        backgroundImage: NetworkImage(channel.snippet.thumbnails.thumbnailsDefault.url),
                      ),
                    );
                  }
                  return Container(
                    width: 50.0,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              title: Text(
                widget.videoModel.snippet.title,
                maxLines: 2,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              subtitle: Text(
                "${widget.videoModel.snippet.channelTitle} · ${widget.videoModel.viewCount} de vistas · hace 5 años",
                style: TextStyle(color: Colors.white54, fontSize: 13.0),
              ),
              trailing: Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
