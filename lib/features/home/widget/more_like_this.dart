import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/home/page/movie_details.dart';
import 'package:movies_app/network/api_manager.dart';

import '../../watch_list/widgets/boxes.dart';
import '../../watch_list/widgets/db.dart';

class MoreLikeThis extends StatefulWidget {
  const MoreLikeThis({super.key, required this.snapshot, required this.popular});

  final AsyncSnapshot snapshot;
  final popular;

  @override
  State<MoreLikeThis> createState() => _MoreLikeThisState();
}

class _MoreLikeThisState extends State<MoreLikeThis> {
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
                "More Like This",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          carousel.CarouselSlider.builder(
              itemCount: 19,
              options: carousel.CarouselOptions(
                  viewportFraction: 0.3,
                  initialPage: 1,
                  enableInfiniteScroll: false,
                  enlargeFactor: 1,
                  height: 190),
              itemBuilder: (context, itemIndex, pageViewIndex) {
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
                                popular: widget.snapshot.data[itemIndex]),
                          ));
                      Apimanger.morlist.clear();
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              '${Constants.urlimage}${widget.snapshot.data[itemIndex].poster}',
                              width: MediaQuery.of(context).size.width,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  boxDb.put(
                                      'key_${widget.snapshot.data[itemIndex].id}',
                                      db(
                                        photo: widget.snapshot.data[itemIndex]
                                            .background,
                                        name: widget
                                            .snapshot.data[itemIndex].title,
                                        date: widget
                                            .snapshot.data[itemIndex].date,
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
                              Text(
                                '${widget.snapshot.data[itemIndex].vote}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 2),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${widget.snapshot.data[itemIndex].title}',
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 2),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${widget.snapshot.data[itemIndex].date}',
                              style: const TextStyle(
                                  fontSize: 8, color: Color(0xffB5B4B4)),
                            ),
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
