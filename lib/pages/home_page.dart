import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/video_model.dart';
import 'package:flutter_codigo5_youapp/services/api_service.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';
import 'package:flutter_codigo5_youapp/ui/widgets/item_filter_widget.dart';
import 'package:flutter_codigo5_youapp/ui/widgets/item_list_video_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final APIService _apiService = APIService();
  List<VideoModel> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    _apiService.getVideos().then((value) {
      videos = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 6.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.explore_outlined),
                          label: Text(
                            "Explorar",
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: kBrandSecondaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0)),
                        ),
                        const SizedBox(
                          height: 32.0,
                          child: VerticalDivider(
                            color: Colors.white24,
                            thickness: 0.9,
                          ),
                        ),
                        ItemFilterWidget(text: "Todos", isSelected: true),
                        ItemFilterWidget(text: "Mixes", isSelected: false),
                        ItemFilterWidget(text: "Música", isSelected: false),
                        ItemFilterWidget(
                            text: "Programación", isSelected: false),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemListVideoWidget(
                        videoModel: videos[index],
                      );
                    },
                  ),
                ],
              ),
            )
          : const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
