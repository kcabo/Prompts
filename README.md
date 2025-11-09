# Personal Prompts

このリポジトリは、Claude Code 等の生成 AI ツール で使用するカスタムプロンプト、スキル、コマンドを管理するための個人用プロジェクトです。

このリポジトリは単一の `utils` プラグインとして構成されています。複数の機能を一つにまとめているのは、個別のバージョン管理の手間を減らしつつ、プラグインという配布単位を開発・運用時に意識せずに済むようにするためです。

※ `marketplace.json` では `"strict": false` と設定しているため、各スキル/コマンドに `plugin.json` は不要です。

## 🗂️ ディレクトリ構造

```
.
├── .claude-plugin/
│   └── marketplace.json    # プラグインマーケットプレイス定義
├── commands/           # Claude Code カスタムスラッシュコマンド
├── skills/             # Claude エージェントスキル
└── system-prompts/     # システムプロンプト (ChatGPT等の汎用チャットボット用)
```

## ✨ 機能一覧

### `skills/gitmoji-commit`

Git コミット時に変更内容を分析し、カスタム gitmoji ルールに従ってコミットメッセージを自動生成します。

### `skills/weather`

東京都の天気予報を取得して表示します。天気予報 API (weather.tsukumijima.net) を使用します。

### `commands/jojo`

ジョジョの奇妙な冒険シリーズから印象的な名言を 1 つ返します。使い方: `/utils:jojo`

## 📚 参考リンク

### Claude Code 公式ドキュメント

- [プラグイン](https://code.claude.com/docs/ja/plugins)
- [プラグインマーケットプレイス](https://code.claude.com/docs/ja/plugin-marketplaces)
- [エージェントスキル](https://code.claude.com/docs/ja/skills)
- [スラッシュコマンド](https://code.claude.com/docs/ja/slash-commands)
- [プラグインリファレンス](https://code.claude.com/docs/ja/plugins-reference)

### 機能関連

- [Gitmoji](https://gitmoji.dev/)
- [天気予報 API](https://weather.tsukumijima.net/)
