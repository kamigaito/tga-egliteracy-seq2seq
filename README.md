# Tsubameを用いたSeq2Seqの実習

# 導入

## 環境変数の設定
`${ROOT_DIR}/.bashrc`中の`${ROOT_DIR}`を環境に応じて書き換える．
初期設定では講義にて使用している`/gs/hs0/tga-egliteracy/egs/seq2seq`に設定されている．

## 環境構築
```
cd ${ROOT_DIR}
chmod +x setup.sh
./setup.sh
```
これにより`${ROOT_DIR}`に
- [anaconda3](https://www.anaconda.com/distribution/)
がインストールされ，
pythonモジュール
- Pytorch
- TorchText
- ConfigArgParse
がインストールされる．
また，
${ROOT_DIR}/appsに必要なツール類
- mosesdecoder
- OpenNMT-py
- [kytea-0.4.7](http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz)
がそれぞれインストールされる．
[kytea](http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz)についてはprefixをkyteaのディレクトリ直下としてインストールされる．

# 実行方法

実行はTsubameのログインノードにおいて
```
./run.sh
```
により行う．

実行後の翻訳結果は
```
# 英語から日本語
${WORK_DIR}/seq2seq/outputs/test.ja
# 日本語から英語
${WORK_DIR}/seq2seq/outputs/test.en
```
のように出力される．
同様に翻訳結果の評価結果も
```
# 英語から日本語
${WORK_DIR}/seq2seq/outputs/result_en-ja.bleu
# 日本語から英語
${WORK_DIR}/seq2seq/outputs/result_ja-en.bleu
```
のように出力される．
`result_en-ja.bleu`は英日翻訳の評価スコア（BLEU）を，
`result_ja-en.bleu`は日英翻訳の評価スコア（BLEU）をそれぞれ含んでいる．
事前に
```
# 英文の入力
${WORK_DIR}/seq2seq/input/user.en
# 日本語文の入力
${WORK_DIR}/seq2seq/input/user.ja
```
上記のファイルを作成し，翻訳を行いたい内容を一行一文で記載することで
任意の内容の翻訳を体験できる．
その場合の翻訳結果は
`${WORK_DIR}/seq2seq/outputs/user.en`
`${WORK_DIR}/seq2seq/outputs/user.ja`
に出力される．
