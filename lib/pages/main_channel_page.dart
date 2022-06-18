
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_codigo5_youapp/models/channel_model.dart';

import '../models/play_list_items_model.dart';
import '../services/api_service.dart';

class MainChannelPage extends StatefulWidget {
  //const MainChannelPage({Key? key}) : super(key: key);

  ChannelModel channel;
  MainChannelPage({
    required this.channel,
});

  @override
  State<MainChannelPage> createState() => _MainChannelPageState();
}

class _MainChannelPageState extends State<MainChannelPage> {

  List<PlayListItemsModel>? playListItemsList;
  final APIService _apiService = APIService();

  getPlayListItemsList()async
  {
    print(widget.channel.contentDetails.relatedPlaylists.uploads);
    playListItemsList = await _apiService.getPlayListItems(widget.channel.contentDetails.relatedPlaylists.uploads);
    setState(() {
      print(playListItemsList!.length);
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getPlayListItemsList();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            child: Image.network(widget.channel.brandingSettings.image.bannerExternalUrl,
            fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10,),
          CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.black12,
            backgroundImage: NetworkImage(widget.channel.snippet.thumbnails.thumbnailsDefault.url ,
            ),
          ),
          const SizedBox(height: 10,),
          Text(widget.channel.snippet.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SUSCRITO",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white54
                ),),
              const SizedBox(width: 20,),
              Icon(Icons.notifications_none_outlined,
                color: Colors.white54,
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${widget.channel.statistics.subscriberCount} suscriptores  ·  ${widget.channel.statistics.videoCount} videos",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70
                  ),)
  ]
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget.channel.brandingSettings.channel.description} ",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70
              ),),
          ),
          const SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: playListItemsList!.length,
            itemBuilder: (BuildContext context, int index) {

              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 90,
                      child: Image.network(playListItemsList![index].snippet!.thumbnails!.thumbnailsDefault.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(playListItemsList![index].snippet!.title,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70
                          ),),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
        
      ),
    );
  }
}
