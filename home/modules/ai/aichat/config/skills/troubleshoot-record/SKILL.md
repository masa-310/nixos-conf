---
name: troubleshoot-record
description:
  技術的な調査（トラブルシュート）を行い、その結果を解説した上で、ObsidianのFleeting Noteとして構造化して保存するスキル。
---

# Troubleshoot and Record

技術的な疑問やトラブルについて、公式ドキュメントや信頼できるソースから調査し、その知見を自分（Agent）の知識として活用すると同時に、ユーザーのObsidian環境に永続的に記録します。

## Workflow

### 1. 調査 (Investigate)
- `webfetch` や `task (explore agent)` を使用して、公式マニュアルから正確な情報を取得する。
- 複数のソースを並列で検索し、情報の正確性を担保する。

### 2. 回答 (Answer)
- 調査結果を簡潔かつ正確にユーザーに解説する。
- 必要に応じて、具体的な実行例やコードを提示する。

### 3. 記録 (Record)
- **テンプレートの使用**: `templates/fleeting/troubleshoot.md` を読み込み、調査内容を流し込む。
- **ファイル作成**: `zettelkasten/fleeting/YYYYMMDD-title.md` という命名規則でファイルを作成する。
- **デイリーノートへのリンク**: 今日のデイリーノート（`zettelkasten/permanent/diary/YYYY-MM-DD.md`）の `## Fleeting Note` セクションに作成したノートへのリンクを追記する。

## Guidelines
- 既に同様のノートが存在するかどうか、事前に `glob` や `grep` で検索し、重複を避けるか、既存のノートを更新する。
- 参照リンクは必ず含める。
- コードブロックには適切な言語シンタックスハイライトを指定する。
