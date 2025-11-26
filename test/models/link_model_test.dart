import 'package:flutter_test/flutter_test.dart';
import 'package:shorten_my_link/models/link_model.dart';

void main() {
  group('Testando AliasModel', () {
    test('Deve criar AliasModel a partir de JSON', () {
      final json = {
        'alias': 'abc123',
        '_links': {
          'self':
              'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
          'short': 'https://example.com',
        },
      };

      final aliasModel = AliasModel.fromJson(json);

      expect(aliasModel.alias, 'abc123');
      expect(
        aliasModel.lLinks.self,
        'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
      );
      expect(aliasModel.lLinks.short, 'https://example.com');
    });

    test('Deve criar AliasModel a partir de JSON string', () {
      const jsonString =
          '{"alias":"abc123","_links":{"self":"https://url-grande-url-grande-url-grande-url-grande.com/abc123","short":"https://example.com"}}';

      final aliasModel = AliasModel.fromJsonString(jsonString);

      expect(aliasModel.alias, 'abc123');
      expect(
        aliasModel.lLinks.self,
        'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
      );
    });

    test('Deve converter AliasModel para JSON', () {
      final aliasModel = AliasModel(
        alias: 'abc123',
        lLinks: LinksModel(
          self:
              'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
          short: 'https://example.com',
        ),
      );

      final json = aliasModel.toJson();

      expect(json['alias'], 'abc123');
      expect(
        json['_links']['self'],
        'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
      );
      expect(json['_links']['short'], 'https://example.com');
    });

    test('Deve converter AliasModel para JSON string', () {
      final aliasModel = AliasModel(
        alias: 'abc123',
        lLinks: LinksModel(
          self:
              'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
          short: 'https://example.com',
        ),
      );

      final jsonString = aliasModel.toJsonString();

      expect(jsonString, contains('abc123'));
      expect(
        jsonString,
        contains(
          'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
        ),
      );
    });
  });

  group('Testando LinksModel', () {
    test('Deve criar LinksModel a partir de JSON', () {
      final json = {
        'self':
            'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
        'short': 'https://example.com',
      };

      final linksModel = LinksModel.fromJson(json);

      expect(
        linksModel.self,
        'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
      );
      expect(linksModel.short, 'https://example.com');
    });

    test('Deve converter LinksModel para JSON', () {
      final linksModel = LinksModel(
        self: 'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
        short: 'https://example.com',
      );

      final json = linksModel.toJson();

      expect(
        json['self'],
        'https://url-grande-url-grande-url-grande-url-grande.com/abc123',
      );
      expect(json['short'], 'https://example.com');
    });
  });
}
