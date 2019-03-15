# Tsubameを用いたSeq2Seqの実習

# 導入

```
git clone --recursive REPOSITORY_NAME
```

`/.bashrc`を環境に応じて書き換える

${ROOTDIR}に
- [anaconda3](https://www.anaconda.com/distribution/)
をインストールする．
インストールが終了したら，次のモジュールを導入する．
- Pytorch
- TorchText
- ConfigArgParse
```
conda install pytorch
conda install torchtext
conda install configargparse
```
[kytea](http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz)についてはprefixをkyteaのディレクトリ直下としてインストールする．
```
# Kyteaのインストール方法
cd apps/kytea-0.4.7
./configure --prefix=$PWD
make
make install
```
もし通常の
```
git clone
```
でインストールを行った場合には，追加で
${ROOTDIR}/appsの
- [OpenNMT-py](https://github.com/OpenNMT/OpenNMT-py.git)
- [mosesdecoder](https://github.com/moses-smt/mosesdecoder.git)
をcloneする．
```
cd apps
git clone https://github.com/OpenNMT/OpenNMT-py.git
git clone https://github.com/moses-smt/mosesdecoder.git
```

# 実行方法

実行はTsubameのログインノードにおいて
```
./run.sh
```
により行う．

実行後の翻訳結果は
```
# 英語から日本語
${WORKDIR}/seq2seq/outputs/test.ja
# 日本語から英語
${WORKDIR}/seq2seq/outputs/test.en
```
のように出力される．
同様に翻訳結果の評価結果も
```
# 英語から日本語
${WORKDIR}/seq2seq/outputs/result_en-ja.bleu
# 日本語から英語
${WORKDIR}/seq2seq/outputs/result_ja-en.bleu
```
のように出力される．
`result_en-ja.bleu`は英日翻訳の評価スコア（BLEU）を，
`result_ja-en.bleu`は日英翻訳の評価スコア（BLEU）をそれぞれ含んでいる．
事前に
```
# 英文の入力
${WORKDIR}/seq2seq/input/user.en
# 日本語文の入力
${WORKDIR}/seq2seq/input/user.ja
```
上記のファイルを作成し，翻訳を行いたい内容を一行一文で記載することで
任意の内容の翻訳を体験できる．
その場合の翻訳結果は
`${WORKDIR}/seq2seq/outputs/user.en`
`${WORKDIR}/seq2seq/outputs/user.ja`
に出力される．
