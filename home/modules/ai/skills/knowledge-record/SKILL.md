---
name: knowledge-record
description: 対話で得られた技術的な知見・設定手順を、ObsidianのFleeting Noteとして構造化して保存する。「メモして」「記録して」「Obsidianに残して」「ナレッジ化して」と言われたとき、あるいは調査済み・既知の知見を永続化したいときに使う。新たな調査が必要な場合は troubleshoot-record を使う。
---

# Record Technical Knowledge

ユーザーとの対話の中で得られた有益な技術的知見や設定手順などを、Obsidian環境に永続的に記録します。

## 前提: Vault 操作は `obsidian-cli`

- Vault への読み書きは `obsidian-cli <command> key=value` を最優先で使う（`sed`/`echo` や直接のファイル書き込みより優先）。Obsidian のインデックスとの不整合を防ぐため。
- `content=` の値では改行を `\n`、タブを `\t` で表現する。値に空白を含む場合は引用符で囲む。
- Vault 共通の運用ルールは `obsidian-cli read path=agent-rules.md` で確認し、それに従う。

## Workflow

### 1. 整理 (Organize)
- 記録すべき知見を整理し、簡潔なタイトルと内容をまとめる。
- ユーザーに記録内容の確認を求める（オプション）。

### 2. 重複確認 (Check)
- `obsidian-cli search query="<キーワード>" path=zettelkasten limit=10` で既存ノートを探す。
- 既存の関連ノートがある場合は新規作成せず、`obsidian-cli append path=<既存ノートのパス> content="..."` で追記・更新する。

### 3. 記録 (Record)
- **テンプレートの使用**: `obsidian-cli read path=templates/fleeting/knowledge.md` を読み込み、内容を流し込む。
- **ファイル作成**: `obsidian-cli create path="zettelkasten/fleeting/YYYYMMDD-title.md" content="..."`
- **メタデータ**: フロントマターに `created_at`（ISO8601）とフェーズのタグ（`fleeting` 等）を付与する。個別プロパティの後付けは `obsidian-cli property:set name=<名前> value=<値> path=<パス>`。

### 4. デイリーノートへのリンク (Link)
- `obsidian-cli daily:path` でパスを取得し、`obsidian-cli daily:read` で現在の内容を確認する。
- `## Fleeting Note` セクション配下に `- [[YYYYMMDD-title]]` を追記する。
- CLI にセクション指定の挿入コマンドが無いため、この追記だけは対象ファイル（Vault ルート `~/private` 配下）を直接編集してよい。末尾追記で構わない場合は `obsidian-cli daily:append content="..."` を使う。

## Guidelines
- タグや内部リンク（`[[ノート名]]`）を適切に設定し、後からの発見性を高める。
- 既存ノートのフロントマター・見出しレベル・タグ命名などのフォーマットを模倣し、破壊的な変更を避ける。
- ファイル削除や大規模な上書きは、必ず事前にユーザーの承認を得る。
