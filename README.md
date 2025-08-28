# 初めに
このプロジェクトは、Fortigateのログを解析し、特定の形式に変換するためのツールです。ログファイルは`src`ディレクトリに配置してください。

# コマンド

`awk`でログをCSVに変換する。

```
$ awk -f script/fglog2csv.awk src/fg.log > src/fg.csv
```

`Ruby`でCSVにおけるIPアドレスを隠蔽する。

```
$ ruby script/hide_ip.rb
```
