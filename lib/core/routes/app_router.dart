import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/home/home_page.dart';
import '../../app/projects/project_detail_page.dart';
import '../../app/sao/sao_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomePage()),
    GoRoute(path: '/sao', builder: (_, _) => const SaoPage()),
    GoRoute(
      name: 'project',
      path: '/projetos/:slug',
      builder: (context, state) =>
          ProjectDetailPage(slug: state.pathParameters['slug'] ?? ''),
    ),
  ],
  errorBuilder: (_, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Esta página não foi encontrada.'),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => appRouter.go('/'),
            child: const Text('Voltar ao portfólio'),
          ),
        ],
      ),
    ),
  ),
);
