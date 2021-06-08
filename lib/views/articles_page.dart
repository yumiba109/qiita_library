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
    final viewModel = useProvider(articleViewModel);
    final state = useProvider(articleViewModel.state);

    if (state.articles.length == 0) {
      if (!state.hasNext) return Text('検索結果なし');
      return const LinearProgressIndicator();
    }

    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (context, int index) {
        if (index == (state.articles.length - 1) && state.hasNext) {
          viewModel.getArticles();
          return const LinearProgressIndicator();
        }
        return _articleItem(state.articles[index]);
      },
    );
  }

  Widget _articleItem(article) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: const Border(
          bottom: const BorderSide(
            color: const Color(0x1e333333),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              for (int i = 0; i < article.tags.length; i++)
                _articleTag(article.tags[i])
            ],
          ),
        ],
      ),
    );
  }

  Widget _articleTag(tag) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 7.5),
        child: Text(
          tag['name'],
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      onTap: () {
        print(tag['name']);
      },
    );
  }
}
