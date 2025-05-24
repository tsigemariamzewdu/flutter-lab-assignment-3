import 'package:album_app/repository/album_repository.dart';
import 'package:album_app/viewmodels/bloc/album_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_router.dart';
import 'data/api_service.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AlbumRepository(apiService),
      child: BlocProvider(
        create: (context) => AlbumBloc(context.read<AlbumRepository>()),
        child: MaterialApp.router(
          title: 'Album App',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: ThemeData(primarySwatch: Colors.blue),
        ),
      ),
    );
  }
}

