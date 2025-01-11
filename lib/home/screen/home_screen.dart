
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_assignment/detail/screen/detail_screen.dart';
import 'package:quadb_assignment/home/application/show_model.dart';
import 'package:quadb_assignment/search/screen/search_screen.dart';

import '../provider/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final List<Movie> movies=movieProvider.movies;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: movieProvider.isLoading?const Center(child: CircularProgressIndicator(),):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Featured Movie Image
                GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      movieProvider.swipeLeftSub(movieProvider.mainIndex);
                      // print("--");
                    } else if (details.primaryVelocity! < 0) {
                      movieProvider.swipeRightAdd(movieProvider.mainIndex);
                    }
                  },
                  child: Consumer<MovieProvider>(
                    builder: (BuildContext context, MovieProvider movieProvider, Widget? child) {
                      return Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: movies[movieProvider.mainIndex].image?.medium != null
                                ? NetworkImage(movies[movieProvider.mainIndex].image!.medium) as ImageProvider
                                : const AssetImage('assets/images/img_1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Top Navigation
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/img.png',
                          height: 40,
                          width: 40,
                          color: Colors.red,
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => const SearchPage()),
                              );
                            });
                          },
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              ignorePointers: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.transparent.withOpacity(0.2),
                                  fontSize: 14,
                                ),
                                suffixIcon: Icon(Icons.search),
                                hintText: "Search",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 20,
                                ),
                                fillColor: Colors.grey,
                                filled: true,
                                alignLabelWithHint: true,
                              ),
                              textInputAction: TextInputAction.search,
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Movie Title and Actions
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          (movies[movieProvider.mainIndex].name).toString(),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white60
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Action • Adventure • Thriller',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              icon: Icons.add,
                              label: 'My List',
                              onTap: () {},
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.play_arrow),
                              label: Text('Play'),
                            ),
                            _buildActionButton(
                              icon: Icons.info_outline,
                              label: 'Info',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Popular Movies Section
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Popular Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => ShowDetailScreen(movie: movies[index],)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: movies[index].image?.medium != null
                            ? NetworkImage(movies[index].image!.medium) as ImageProvider
                            : const AssetImage('assets/images/img_1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}