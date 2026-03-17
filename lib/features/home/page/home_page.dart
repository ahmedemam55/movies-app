import 'package:flutter/material.dart';
import 'package:movies_app/features/home/widget/home_loading.dart';
import 'package:movies_app/features/home/widget/recomended_loding.dart';
import 'package:movies_app/features/home/widget/home_widget.dart';
import 'package:movies_app/features/home/widget/recomended_widget.dart';
import 'package:movies_app/features/home/widget/releases_loading.dart';
import 'package:movies_app/features/home/widget/releases_widget.dart';
import 'package:movies_app/models/popular.dart';
import 'package:movies_app/network/api_manager.dart';

class HomePage extends StatefulWidget {
  static String routeName = "HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Popular>> popularMovies;
  late Future<List<Popular>> newReleases;
  late Future<List<Popular>> recomended;

  @override
  void initState() {
    super.initState();
    popularMovies = Apimanger().getPopular();
    newReleases = Apimanger().getNewReleases();
    recomended = Apimanger().getReconended();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Popular>>(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  return HomeWidget(snapshot: snapshot);
                } else {
                  return const HomeLoading();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 20),
              child: FutureBuilder<List<Popular>>(
                future: newReleases,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return ReleasesWidget(snapshot: snapshot);
                  } else {
                    return const ReleasesLoading();
                  }
                },
              ),
            ),
            FutureBuilder<List<Popular>>(
              future: recomended,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  return RecomendedWidget(snapshot: snapshot);
                } else {
                  return const RecomendedLoading();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
