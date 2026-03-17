# 個人的なvcpkg portのリポジトリ

このリポジトリは、私が個人的に管理しているvcpkg portのリポジトリです。
汎用的な用途には耐えられないため、できるだけ公式vcpkgを使用するようにしてください。

## 目的

このリポジトリの目的は、私が使用するライブラリのportを管理し簡単に利用できるようにすることです。
独自のライブラリが必要な理由はだいたい以下の通りです。

- 公式のportでは許可されていない機能を有効にしたいため
- 公式のportではサポートされていないバージョンを使用したいため
- 個人的なライブラリをvcpkg経由で利用したいため

また、他の人が私のportを参考にして、自分のプロジェクトに適したportを作成することも目的としています。

## 使用方法

使用するvcpkg.jsonと同じディレクトリに、以下のようなvcpkg-ports.jsonを作成してください。

```json
{
  "default-registry": {
    "kind": "builtin",
    "baseline": "cdfdcd51b31c534c5ba991ee586c176c46385cd6"
  },
  "registries": [
    {
      "kind": "git",
      "repository": "https://github.com/toge/my-vcpkg-ports",
      "baseline": "3c7e1a03e2d3f474a7885a0e6deb7cc311e50329",
      "packages": [ "<利用したいport名>" ]
    }
  ]
}
```

それぞれのbaselineの値は、リポジトリの最新のコミットハッシュにしてください。
gitリポジトリの最新版に更新するには`vcpkg x-update-baseline`コマンドが便利です。

## 注意事項

- このリポジトリのportは私が使用するライブラリに特化しているため、他の人の使用には適さない可能性があります。
  - 私の開発環境は主にx86-64 LinuxやARM64 Linux, ARM64 macOSXです。
- 公式のportを上書きしているportについては、それに依存する公式portの動作を保証しません。使用する際には注意してください。

## 公式にマージさせる予定のないport

公式vcpkgの方針や、私の個人的な事情で、公式にマージされる予定のないportとその理由は以下の通りです。

| port名      | 理由                                                                       |
| ----------- | -------------------------------------------------------------------------- |
| frozenchars | 個人的なライブラリで汎用的な用途に耐えられないため                         |
| jpegli      | 公式の方針でlibjpeg-turboと一部ファイルが重複するportは登録できないため    |
| wxwidgets   | 公式の方針でUTF8をサポートするためのコンパイルオプションを追加できないため |
| zxcpp       | 個人的なライブラリで汎用的な用途に耐えられないため                         |

これ以外については徐々に公式にマージするためにPRを作成していく予定です。
マージされたportはこのリポジトリから削除する予定です。

## ライセンス

このリポジトリのコードは、MIT Licenseの下でライセンスされています。詳細はLICENSEファイルを参照してください。

## メンテナンス用のコマンド群

このリポジトリもしくは、このリポジトリをforkしたリポジトリを使用して、vcpkgのportを管理する場合、以下のコマンドを使用してください。
実行する際にはcloneしたリポジトリのルートディレクトリをカレントディレクトリにしてください。

### パッケージのインストール

インストールするport名を指定して以下のコマンドを実行してください。

```bash
vcpkg install  --classic --recurse --overlay-ports=./ports <port-name>
```

### versionの更新

cloneしたリポジトリのルートディレクトリで、以下のコマンドを実行してください。

```bash
vcpkg x-add-version --all --overwrite-version \
                    --x-builtin-ports-root=./ports \
                    --x-builtin-registry-versions-dir=./versions \
                    --skip-version-format-check
```
