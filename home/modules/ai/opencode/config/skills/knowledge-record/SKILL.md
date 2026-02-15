---
name: knowledge-record
description:
  ユーザーから提供された、あるいは対話を通じて得られた技術的な知見を、ObsidianのFleeting Noteとして構造化して保存するスキル。
---

# Record Technical Knowledge

ユーザーとの対話の中で得られた有益な技術的知見や設定手順などを、Obsidian環境に永続的に記録します。

## Workflow

### 1. 整理 (Organize)
- 記録すべき知見を整理し、簡潔なタイトルと内容をまとめる。
- ユーザーに記録内容の確認を求める（オプション）。

### 2. 記録 (Record)
- **テンプレートの使用**: `templates/fleeting/knowledge.md` を読み込み、内容を流し込む。
- **ファイル作成**: `zettelkasten/fleeting/YYYYMMDD-title.md` という命名規則でファイルを作成する。
- **デイリーノートへのリンク**: 今日のデイリーノート（`zettelkasten/permanent/diary/YYYY-MM-DD.md`）の `## Fleeting Note` セクションに作成したノートへのリンクを追記する。

## Guidelines
- 既存の関連ノートがある場合は、新規作成ではなく追記や更新を検討する。
- タグや内部リンクを適切に設定し、後からの発見性を高める。
