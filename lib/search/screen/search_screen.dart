import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int calculateStars(num rating) {
    return (rating / 2).round();
  }

  final TextEditingController searchQuery = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SearchProvider>(context, listen: false).fetchMovies());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const Icon(
          CupertinoIcons.line_horizontal_3_decrease,
          color: Colors.white,
        ),
        title: Image.asset(
          'assets/images/img.png',
          height: kToolbarHeight - 25,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Search Bar
              SizedBox(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchQuery,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          provider.updateQuery(value);
                        },
                        onChanged: (val){
                          if(val==''){
                            provider.updateQuery('all');
                          }
                        },

                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        provider.updateQuery(searchQuery.text);
                      },
                      child: Container(
                        height: 38,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffF62E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          CupertinoIcons.search,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Movies List
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.movies.isEmpty
                  ? const Center(
                  child: Text('No movies found',
                      style: TextStyle(color: Colors.white)))
                  : Column(
                children: provider.movies.map((movie) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 190,
                            width: 140,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.black,
                                Colors.grey.shade900
                              ]),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: movie.image?.medium != null
                                    ? NetworkImage(movie.image!.medium)
                                    : const AssetImage('assets/images/img_1.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.name.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                movie.rating?.average != null
                                    ? Row(
                                  children: [
                                    ...List.generate(
                                      calculateStars(movie
                                          .rating!.average!),
                                          (index) => const Padding(
                                        padding:
                                        EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons
                                              .star_purple500_outlined,
                                          size: 15,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                    ...List.generate(
                                      5 -
                                          calculateStars(movie
                                              .rating!
                                              .average!),
                                          (index) => const Padding(
                                        padding:
                                        EdgeInsets.all(2.0),
                                        child: Icon(
                                          Icons
                                              .star_purple500_outlined,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    : Row(
                                  children: List.generate(
                                    5,
                                        (index) => const Padding(
                                      padding:
                                      EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons
                                            .star_purple500_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  movie.rating?.average != null?(movie.rating?.average).toString():"",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                movie.summary.toString(),
                                maxLines: 3,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
