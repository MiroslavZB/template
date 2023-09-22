import 'package:flutter/material.dart';
import 'package:template/components/shared/auth_wrap.dart';
import 'package:template/models/page.dart';
import 'package:template/pages/home_page.dart';

final homePage = AppPage(
  index: 0,
  page: const AuthWrap(page: HomePage()),
  icon: Icons.home,
);
