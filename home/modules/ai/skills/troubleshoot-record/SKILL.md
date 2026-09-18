---
name: troubleshoot-record
description: 技術的な疑問やトラブルを公式ドキュメントで調査し、解説した上で結果をObsidianのFleeting Noteとして保存する。「調べて記録して」「調査してメモして」のように調査と記録の両方を求められたとき、あるいはトラブルシュートの結論を残したいときに使う。調査が不要なら knowledge-record を使う。
---

# Troubleshoot and Record

技術的な疑問やトラブルについて、公式ドキュメントや信頼できるソースから調査し、その知見を自分（Agent）の知識として活用すると同時に、ユーザーのObsidian環境に永続的に記録します。

## 前提: Vault 操作は `obsidian-cli`

- Vault への読み書きは `obsidian-cli <command> key=value` を最優先で使う（`sed`/`echo` や直接のファイル書き込みより優先）。Obsidian のインデックスとの不整合を防ぐため。
- `content=` の値では改行を `\n`、タブを `\t` で表現する。値に空白を含む場合は引用符で囲む。
- Vault 共通の運用ルールは `obsidian-cli read path=agent-rules.md` で確認し、それに従う。

## Workflow

### 1. 調査 (Investigate)
- 公式ドキュメントを Web から取得し、正確な一次情報を参照する。
- 調査範囲が広い場合はサブエージェントに委譲し、複数のソースを並列で確認して情報の正確性を担保する。

### 2. 回答 (Answer)
- 調査結果を簡潔かつ正確にユーザーに解説する。
- 必要に応じて、具体的な実行例やコードを提示する。

### 3. 重複確認 (Check)
- `obsidian-cli search query="<キーワード>" path=zettelkasten limit=10` で同様のノートの有無を確認する。
- 既存ノートがあれば新規作成せず、`obsidian-cli append path=<既存ノートのパス> content="..."` で追記・更新する。

### 4. 記録 (Record)
- **テンプレートの使用**: `obsidian-cli read path=templates/fleeting/troubleshoot.md` を読み込み、調査内容を流し込む。
- **ファイル作成**: `obsidian-cli create path="zettelkasten/fleeting/YYYYMMDD-title.md" content="..."`
- **メタデータ**: フロントマターに `created_at`（ISO8601）とフェーズのタグ（`fleeting` 等）を付与する。個別プロパティの後付けは `obsidian-cli property:set name=<名前> value=<値> path=<パス>`。

### 5. デイリーノートへのリンク (Link)
- `obsidian-cli daily:path` でパスを取得し、`obsidian-cli daily:read` で現在の内容を確認する。
- `## Fleeting Note` セクション配下に `- [[YYYYMMDD-title]]` を追記する。
- CLI にセクション指定の挿入コマンドが無いため、この追記だけは対象ファイル（Vault ルート `~/private` 配下）を直接編集してよい。末尾追記で構わない場合は `obsidian-cli daily:append content="..."` を使う。

## Guidelines
- 参照リンクは必ず含める。
- コードブロックには適切な言語シンタックスハイライトを指定する。
- 既存ノートのフロントマター・見出しレベル・タグ命名などのフォーマットを模倣し、破壊的な変更を避ける。
- ファイル削除や大規模な上書きは、必ず事前にユーザーの承認を得る。
