import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/channel_model.dart';
import 'package:flutter_codigo5_youapp/pages/main_channel_page.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';

class ChannelPage extends StatefulWidget {

  ChannelModel channel;

  ChannelPage({
    required this.channel,
});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Text(widget.channel.snippet.title),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 2.7,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("PÁGINA PRINCIPAL", style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("VIDEOS", style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("LISTA DE REPRODUCCIÓN", style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("COMUNIDAD", style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("CANALES", style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("MÁS INFORMACIÓN", style: TextStyle(fontSize: 16.0,),),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: this._tabController,
          children: [
            MainChannelPage(channel: widget.channel),
            Center(child: Text("Página VIDEOS"),),
            Center(child: Text("Página LISTA DE REPRODUCCIÓN"),),
            Center(child: Text("Página COMUNIDAD"),),
            Center(child: Text("Página CANALES"),),
            Center(child: Text("Página MÁS INFORMACIÓN"),),
          ],
        ),
      ),
    );
  }
}
