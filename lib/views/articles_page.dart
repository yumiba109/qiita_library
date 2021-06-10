import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_library/viewModels/article_view_model.dart';
import 'package:intl/intl.dart';
import 'package:qiita_library/views/article_datail_page.dart';
import 'package:qiita_library/views/article_search_setting_page.dart';

class ArticlesPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ArticleSearchSettingPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
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
        return _articleItem(context, state.articles[index]);
      },
    );
  }

  Widget _articleItem(context, article) {
    return GestureDetector(
      child: Container(
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
            _articleUser(article.user),
            SizedBox(
              height: 10.0,
            ),
            Text(article.title),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              spacing: 7.5,
              children: <Widget>[
                for (int i = 0; i < article.tags.length; i++)
                  _articleTag(article.tags[i])
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            _articleCreatedAt(article.createdAt),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(
              article: article,
            ),
          ),
        );
      },
    );
  }

  Widget _articleUser(user) {
    final userId = user.id;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.profileImageUrl),
          radius: 12.0,
          child: Text(''),
        ),
        SizedBox(width: 8.0),
        Text('@$userId'),
      ],
    );
  }

  Widget _articleTag(tag) {
    return GestureDetector(
      child: Container(
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

  Widget _articleCreatedAt(createdAt) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    String date = format.format(DateTime.parse(createdAt).toLocal());

    return Container(
      width: double.infinity,
      child: Text(
        '$dateに投稿',
        textAlign: TextAlign.right,
      ),
    );
  }
}
