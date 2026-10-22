# Qt 6.9 以降の uic は先頭に `::` が付いたクラス名を不正として拒否する。
# mozc 2.30.5544.102 の dictionary_tool.ui が
# `::mozc::gui::DictionaryContentTableWidget` を使っているためビルドが失敗する。
#   gui/dictionary_tool/dictionary_tool.ui: Invalid class name: "::mozc::gui::DictionaryContentTableWidget"
# 先頭の `::` を落としても解決先は変わらないので取り除く。
# upstream nixpkgs が修正したらこのファイルごと削除してよい。
final: prev: {
  mozc = prev.mozc.overrideAttrs (old: {
    # fetchAttrs 側(固定出力の deps)に影響しないよう postPatch ではなく preBuild で当てる。
    # preConfigure で `cd src` 済みなので相対パスは src/ 起点。
    preBuild = (old.preBuild or "") + ''
      substituteInPlace gui/dictionary_tool/dictionary_tool.ui \
        --replace-fail "::mozc::gui::DictionaryContentTableWidget" "mozc::gui::DictionaryContentTableWidget"
    '';
  });
}
