import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_library/viewModels/article_view_model.dart';

class ArticlesPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('記事一覧'),
      ),
      body: _Articles(),
    );
  }
}

class _Articles extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(articleViewModel.state);

    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (context, int index) {
        return Text(state.articles[index].title);
      },
    );
  }
}
