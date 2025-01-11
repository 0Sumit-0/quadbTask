import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/application/show_model.dart';
import '../../home/provider/home_provider.dart';

class ShowDetailScreen extends StatefulWidget {
  final Movie movie;
  const ShowDetailScreen({required this.movie,super.key});

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MovieProvider>(context, listen: false);
      provider.fetchEpisode(widget.movie.id ?? 1844093);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: _buildHeader()),
            _buildTitle(),
            _buildButtons(),
            _buildDescription(),
            _buildActionButtons(),
            _buildTabBar(),
            _buildEpisodesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.movie.image?.medium != null
                  ? NetworkImage(widget.movie.image!.medium) as ImageProvider
                  : const AssetImage('assets/images/img_1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          top: 40,
          left: 16,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Positioned.fill(
          child: Center(
            child: Icon(
              Icons.play_circle_outline,
              size: 60,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            (widget.movie.name).toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          Text(
            (widget.movie.language).toString(),
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              'HD',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.star, color: Colors.amber, size: 16),
          Text(
            widget.movie.rating?.average!=null?(widget.movie.rating?.average).toString():'',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(double.infinity, 45),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Play',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey),
              minimumSize: Size(double.infinity, 45),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Download',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        (widget.movie.summary).toString(),
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.add, 'My List'),
        _buildActionButton(Icons.thumb_up_outlined, 'Rate'),
        _buildActionButton(Icons.share, 'Share'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTab('EPISODES', isSelected: true),
            _buildTab('MORE LIKE THIS'),
            _buildTab('TRAILERS & MORE'),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTab(String text, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            height: 2,
            width: 40,
            margin: EdgeInsets.only(top: 4),
            color: Colors.red,
          ),
      ],
    );
  }

  Widget _buildEpisodesSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Series 1',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildEpisodeItem(context),
        ],
      ),
    );
  }

  Widget _buildEpisodeItem(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final episode = provider.episode;

        if (episode == null) {
          return const Center(child: Text("No episode data available", style: TextStyle(color: Colors.white)));
        }

        return Row(
          children: [
            Container(
              width: 120,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: episode.image?.medium!=null
                      ? NetworkImage(episode.image!.medium)
                      : const AssetImage('assets/images/img_1.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${episode.number}. ${episode.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.download_outlined, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        episode.rating?.average != null?(episode.rating?.average).toString() : '',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}