# Tsubameを用いたSeq2Seqの実習

# 実行方法

実行はTsubameのログインノードにおいて
```
./run.sh
```
により行う．

デフォルトでは日英翻訳のみ行う．英日翻訳を行いたい場合，run.sh内の
```
LANG_PAIR=ja-en #japanese -> english
#LANG_PAIR=en-ja #english -> japanese
```
を次のように書き換える．
```
#LANG_PAIR=ja-en #japanese -> english
LANG_PAIR=en-ja #english -> japanese
```


実行後の翻訳結果は
```
# 英語から日本語
${WORK_DIR}/outputs/test.ja
# 日本語から英語
${WORK_DIR}/outputs/test.en
```
のように出力される．
同様に翻訳結果の評価結果も
```
# 英語から日本語
${WORK_DIR}/outputs/result_en-ja.bleu
# 日本語から英語
${WORK_DIR}/outputs/result_ja-en.bleu
```
のように出力される．
`result_en-ja.bleu`は英日翻訳の評価スコア（BLEU）を，
`result_ja-en.bleu`は日英翻訳の評価スコア（BLEU）をそれぞれ含んでいる．
事前に
```
# 英文の入力
${WORK_DIR}/input/user.en
# 日本語文の入力
${WORK_DIR}/input/user.ja
```
上記のファイルを作成し，翻訳を行いたい内容を一行一文で記載することで
任意の内容の翻訳を体験できる．
その場合の翻訳結果は
`${WORK_DIR}/outputs/user.en`
`${WORK_DIR}/outputs/user.ja`
に出力される．
