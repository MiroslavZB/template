import 'package:flutter/material.dart';
import 'package:template/modules/feed/home_page.dart';
import 'package:template/modules/routing/app_page.dart';
import 'package:template/modules/user/profile_page.dart';

final homePage = AppPage(
  index: 0,
  page: const HomePage(),
  icon: Icons.home,
);

final profilePage = AppPage(
  index: 1,
  page: const ProfilePage(),
  icon: Icons.person,
);
