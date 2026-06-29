import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/fetch_song_cubit.dart';
import 'package:musiq/core/helper_funtions.dart';
import 'package:musiq/data/yt_services/youtube_scraper_service.dart';
import 'package:musiq/models/song_model/song.dart';

class YtHomeScreen extends StatefulWidget {
  const YtHomeScreen({super.key});

  @override
  State<YtHomeScreen> createState() => _YtHomeScreenState();
}

class _YtHomeScreenState extends State<YtHomeScreen> {
  late Future<List<YouTubeMusicSection>> _sectionsFuture;

  @override
  void initState() {
    super.initState();
    _sectionsFuture = YouTubeScraperService.instance.fetchHomeSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<YouTubeMusicSection>>(
        future: _sectionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final sections = snapshot.data ?? [];
          if (sections.isEmpty) {
            return const Center(child: Text("No music found"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _sectionsFuture =
                    YouTubeScraperService.instance.fetchHomeSections();
              });
              await _sectionsFuture;
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 110),
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];
                return _HorizontalList(section: section);
              },
            ),
          );
        },
      ),
    );
  }
}

class _HorizontalList extends StatelessWidget {
  final YouTubeMusicSection section;

  const _HorizontalList({required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          child: Text(
            section.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 215,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: section.songs.length,
            itemBuilder: (context, index) {
              final song = section.songs[index];
              return GestureDetector(
                onTap: () {
                  context.read<FetchSongCubit>().fetchData(
                        type: "song",
                        id: song.id ?? "",
                        imageUrl: song.image?.first.imageUrl ?? errorImage(),
                        song: song,
                      );
                },
                child: _SongCard(song: song),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SongCard extends StatelessWidget {
  final Song song;

  const _SongCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: song.image?.first.imageUrl ?? errorImage(),
              width: 165,
              height: 110,
              fit: BoxFit.cover,
              placeholder: (context, url) => songImagePlaceholder(),
              errorWidget: (context, url, error) => songImagePlaceholder(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            song.name ?? "Unknown",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            song.label ?? "YouTube",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
