# 初めに
このプロジェクトは、Fortigateのログを解析し、特定の形式に変換するためのツールです。ログファイルは`src`ディレクトリに配置してください。

# コマンド

`awk`でログをCSVに変換する。

> [!NOTE]
> `src/fg.csv`は元のCSVファイル、`src/fg_out.csv`はIPアドレスが隠蔽されたCSVファイルです。

```bash
$ awk -f script/fglog2csv.awk src/fg.log > src/fg.csv
```

`Ruby`でCSVにおけるIPアドレスを隠蔽する。

```bash
$ ruby script/hide_ip.rb
```

`Ruby`でCSVにおけるIPアドレスを隠蔽する（改良版）。

```bash
$ ruby script/hide_ip2.rb
```

`awk`でCSVにおけるIPアドレスを隠蔽する。

```bash
$ awk -F, -f script/hide_ip2.awk src/fg.csv > src/fg_out.csv
```

> [!IMPORTANT]
> `awk`による実装はまだ途中です。
