import 'package:flutter/material.dart';
import 'package:playground/ui/routes.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards Room'),
      ),
      body: ListView(
        children: [
          _CardWidget(id: '1'),
          _CardWidget(id: '2'),
          _CardWidget(id: '3'),
          _CardWidget(id: '4'),
          _CardWidget(id: '6'),
          _CardWidget(id: '7'),
          _CardWidget(id: '8'),
        ],
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({Key key, this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Hero(
      tag: id,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ООО "Агро-Сбыт"',
                  style: theme.textTheme.subhead.copyWith(color: theme.accentColor),
                ),
                const SizedBox(height: 4),
                Wrap(                  
                  spacing: 8,
                  children: <Widget>[
                    Text(
                      'Дмитрий Фукалов',
                      style: theme.textTheme.caption.copyWith(color: Colors.black87),
                    ),
                    Text(
                      '14 ноя 12:01',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Добрый день! В связи с небольшой поломкой и поздней загузкой, произошла задержка в сроках доставки груза. Авомобиль на выгрузке будет 20.10.2018',
                  style: theme.textTheme.body1.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, Routes.CARD_DETAILS, arguments: id);
          },
        ),
      ),
    );
  }
}
