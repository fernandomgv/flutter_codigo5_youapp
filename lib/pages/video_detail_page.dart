import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/comment_model.dart';
import 'package:flutter_codigo5_youapp/pages/channel_page.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/channel_model.dart';
import '../models/video_model.dart';
import '../services/api_service.dart';
import '../ui/widgets/item_review_widget.dart';

class VideoDetailPage extends StatefulWidget {

  VideoModel videoModel;
  final APIService _apiService = APIService();
  VideoDetailPage({required this.videoModel});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late YoutubePlayerController _controller;
  String videoId ="";
  ChannelModel? channelModel;
  List<CommentModel>? comments;
  final APIService _apiService = APIService();

  getChannel()async{
    channelModel = await _apiService.getChannel(widget.videoModel.snippet.channelId);
    print(widget.videoModel.snippet.channelId);
    setState(() {

    });

  }

  getComments() async{
    comments = await _apiService.getCommentsVideo(widget.videoModel.id.videoId);
    print(" tenemos ${comments!.length} comentarios para este video");
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoId = widget.videoModel.id.videoId;
    print("videoId en VideoDetailPage: ${videoId}");
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
      ),
    );
    getChannel();
    getComments();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.35,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: false,
              progressColors: ProgressBarColors(
                backgroundColor: Colors.white.withOpacity(0.1),
                bufferedColor: Colors.white54,
                handleColor: Colors.red,
                playedColor: Colors.red,
              ),
              // bottomActions: [
              //
              // ],
              // thumbnail: Text(
              //   "Hola",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 20.0,
              //   ),
              // ),
            ),
          ),
          ListTile(
            title: Text(
              widget.videoModel.snippet.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white, fontSize: 14.0, height: 1.3),
            ),
            subtitle: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child:  Text(
                "${widget.videoModel.viewCount} de vistas · hace 5 años ",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13.0,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconDetailVideoWidget(
                            icon: Icons.thumb_up_alt_outlined,
                            text: "354 K",
                          ),
                          IconDetailVideoWidget(
                            icon: Icons.thumb_down_alt_outlined,
                            text: "No me gusta",
                          ),
                          IconDetailVideoWidget(
                            icon: Icons.share,
                            text: "Compartir",
                          ),
                          IconDetailVideoWidget(
                            icon: Icons.download_rounded,
                            text: "Descargar",
                          ),
                          IconDetailVideoWidget(
                            icon: Icons.cut,
                            text: "Recortar",
                          ),
                          IconDetailVideoWidget(
                            icon: Icons.library_add_outlined,
                            text: "Guardar",
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChannelPage(channel: channelModel!,)));
                      },
                      child: Row(
                        children: [

                          CircleAvatar(
                            backgroundColor: Colors.black12,
                            backgroundImage: NetworkImage( channelModel != null ? channelModel!.snippet.thumbnails.thumbnailsDefault.url :
                              "https://images.pexels.com/photos/11482693/pexels-photo-11482693.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(channelModel != null ? channelModel!.snippet.title :
                                  "vizmedia",
                                    style: TextStyle(color: Colors.white70, fontSize: 15.0),
                                  ),
                                  Text(
                                    "234 K suscriptores",
                                    style: TextStyle(color: Colors.white54, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ),





                          Text(
                            "SUSCRIBIRSE",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white12,
                  ),
                  Column(
                    children: comments!
                        .map((e) => ItemReviewWidget(
                      reviewsModel: e,
                    ))
                        .toList()

                    ,
                  ),
                  Container(
                    height: 200,
                    color: Colors.purpleAccent,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 200,
                    color: Colors.purpleAccent,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 200,
                    color: Colors.purpleAccent,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                  Container(
                    height: 200,
                    color: Colors.purpleAccent,
                  ),
                  Container(
                    height: 200,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconDetailVideoWidget extends StatelessWidget {
  IconData icon;
  String text;

  IconDetailVideoWidget({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 26.0,
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.white60,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
