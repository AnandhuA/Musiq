import 'package:flutter/material.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/presentation/screens/youtube/yt_player.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';



class YtHomeScreen extends StatefulWidget {
  const YtHomeScreen({super.key});

  @override
  State<YtHomeScreen> createState() => _YtHomeScreenState();
}

class _YtHomeScreenState extends State<YtHomeScreen> {
  final YoutubeDataApi youtubeDataApi = YoutubeDataApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HorizontalList(futureFun: youtubeDataApi.fetchTrendingMusic()),
            _HorizontalList(futureFun: youtubeDataApi.fetchTrendingVideo()),
            _HorizontalList(futureFun: youtubeDataApi.fetchTrendingMovies()),
            _HorizontalList(futureFun: youtubeDataApi.fetchTrendingGaming()),
          ],
        ),
      ),
    );
  }
}

class _HorizontalList extends StatelessWidget {
  final Future<List<Video>>? futureFun;
  const _HorizontalList({required this.futureFun});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<Video>>(
        future: futureFun,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No videos found"));
          }

          final videos = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YtMusicPlayerScreen(
                        videoId: video.videoId ?? "Non",
                        title: video.title ?? "Unknown",
                        thumbnailUrl: video.thumbnails?.first.url ?? "",
                        channelName: video.channelName ?? "Unknown",
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          video.thumbnails?.first.url ?? errorImage(),
                          width: 160,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        video.title ?? "Nothing",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        video.channelName ?? "Unknown",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
