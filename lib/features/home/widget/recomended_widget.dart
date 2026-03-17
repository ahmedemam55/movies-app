import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/home/page/movie_details.dart';
import 'package:movies_app/network/api_manager.dart';

import '../../watch_list/widgets/boxes.dart';
import '../../watch_list/widgets/db.dart';

class RecomendedWidget extends StatefulWidget {
  const RecomendedWidget({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  State<RecomendedWidget> createState() => _RecomendedWidgetState();
}

class _RecomendedWidgetState extends State<RecomendedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      color: const Color(0xff282A28),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Recomended",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          carousel.CarouselSlider.builder(
              itemCount: (widget.snapshot.data?.length ?? 0) > 20 ? 20 : (widget.snapshot.data?.length ?? 0),
              options: carousel.CarouselOptions(
                  viewportFraction: 0.3,
                  initialPage: 1,
                  enableInfiniteScroll: false,
                  enlargeFactor: 1,
                  height: 200), // زيادة الارتفاع قليلاً لضمان عدم حدوث Overflow
              itemBuilder: (context, itemIndex, pageViewIndex) {
                var movie = widget.snapshot.data[itemIndex];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  color: const Color(0xff343534),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetails(
                                popular: movie),
                          ));
                      Apimanger.morlist.clear();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            movie.poster.isNotEmpty 
                            ? Image.network(
                              '${Constants.urlimage}${movie.poster}',
                              width: 100,
                              height: 125, // تحديد ارتفاع ثابت للصورة
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(
                                height: 125,
                                child: Center(child: Icon(Icons.error, color: Colors.white)),
                              ),
                            )
                            : const SizedBox(
                                height: 125,
                                child: Center(child: Icon(Icons.movie, color: Colors.white, size: 50))
                              ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  boxDb.put(
                                      'key_${movie.id}',
                                      db(
                                        photo: movie.background,
                                        name: movie.title,
                                        date: movie.date,
                                      ));
                                });
                              },
                              child: Image.asset(
                                "assets/image/icon_add.png",
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xffFFBB3B),
                                size: 15,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${movie.rate}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 2),
                          child: Text(
                            '${movie.title}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                            maxLines: 1, // حصر العنوان في سطر واحد
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 2),
                          child: Text(
                            '${movie.date}',
                            style: const TextStyle(
                                fontSize: 8, color: Color(0xffB5B4B4)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
