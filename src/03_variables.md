## 変数

今度は二回立て続けに`Hello, World!`と出力するプログラムに改造しよう。
これはなんのこともなく、`Serial.print`を二回書くことで実現できる。

```cpp
void setup() {
  Serial.begin(9600);
  Serial.print("Hello, World!");
  Serial.print("Hello, World!");
}
void loop() {
}
```

これを実行すると、次のような出力が得られる。

```
Hello, World!Hello, World!
```

多分想定していたものとちょっと違うはずだ。なんとなく一つ目の`Hello, World!`と
２つめの`Hello, World!`の間に改行が挟まっていることを期待していたと思う。
では、どうやって改行を表示するのだろうか？二重引用符の中身が出力されるわけだし、
一つ目の`Hello, World!`のあとに改行を入れてしまえばいいいんじゃないか？
と思った人もいるかもしれない。それじゃあ、実際試してみよう。

```cpp
void setup() {
  Serial.begin(9600);
  Serial.print("Hello, World!
");
  Serial.print("Hello, World!");
}
void loop() {
}
```

コンパイルをしてみると、`missing terminating " character`と怒られてしまう。
どうやら二重引用符の間に改行は入れてはいけないようだ。
そこでどうするかというと、**エスケープシーケンス**というものを使う。
エスケープシーケンスとは、通常の文字列で表現できない改行やタブなどを表現する
ための表記法だ。ひとまず改行用のエスケープシーケンス、`\n`だけを紹介する。
（パソコンによっては`\`キーを押しても`¥`マークが入力される場合がある。
`\`の代わりに`¥`を使っても問題ないため、適宜読み替えてほしい。）

これを`Serial.print`に渡す文字列の最後に次のようにつける。
（後でさらに`Serial.print`を追加するときに備えて最初の`"Hello, World!"`だけ
ではなく、二個目にもつけておこう）

```cpp
void setup() {
  Serial.begin(9600);
  Serial.print("Hello, World!\n");
  Serial.print("Hello, World!\n");
}
void loop() {
}
```

これを実行すると、無事次の出力が得られる。

```
Hello, World!
Hello, World!
```

ここで、`Hello, World!`を二回書いていることに注目してほしい。
今回はそこまで長い文字列ではないためそこまでの苦痛ではないかもしれないが、
これがずっとながかったり、あるいは何度もプログラム中に登場したりしたと
するといちいち同じものをコピペするのも面倒くさい。そして例えば、その
ダブった中身を書き換えるとなると、プログラム中に書いた回数だけ書き換える必要
がでてきてそれも面倒くさそうだ。

そんなときは、**変数**を使って名前をつけてまとめてしまおう。

```cpp
void setup() {
  Serial.begin(9600);
  String message = "Hello, World!\n";
  Serial.print(message);
  Serial.print(message);
}
void loop() {
}
```

<!-- TODO: check if code works! -->

一つ前のプログラムとよく見比べてみよう。`String message = "Hello, World!";`
という行が増えて、`Serial.pring`の呼び出しに渡されていた`"Hello, World!"`が
`message`に変わっている。これは何をしたかというと、`"Hello, World!"`という
文字列型（`String`） のデータを`message`という名前の変数に入れている。
この行の`String message`というのは、`String`型の`message`という名前の変数を
使うということを示しており、これを変数の**宣言**と呼ぶ。
そして、次の二行の`Serial.print`で文字列を直接渡す代わりに変数を渡している。
これで二度手間が省けたうえ、`Serial.print`に渡しているデータはメッセージだという
ことを示せている。変数のもう一つのポイントとして、変数名
（上の例の場合は`message`にあたる）はなんでもよい。
つまり、`message`ではなく`greeting`という名前を変数につけて次のように使っても、
プログラムの動作に違いはない。つまり、変数名はプログラムする人にとって
わかりやすいものであればなんでもよい。

```cpp
void setup() {
  Serial.begin(9600);
  String greeting = "Hello, World!\n";
  Serial.print(greeting);
  Serial.print(greeting);
}
void loop() {
}
```

練習問題: 上のコードを`Hello, World!`ではなく`Hello, Arduino World!`と
二回表示するように変更してみよう。

今回の例では文字列型のデータを扱っているが、別な型のデータも同様に変数に
入れて扱うこともできる。例えば、`Serial.begin`で設定しているボードレート、
一見なんなのかわからないから変数で表してみたいとしよう。数字（正確には整数）
型の名前は`int`だから次のように今回の例を書き直すことができる。

```cpp
void setup() {
  int baudRate = 9600;
  Serial.begin(baudRate);
  String message = "Hello, World!\n";
  Serial.print(message);
  Serial.print(message);
}
void loop() {
}
```

ここで`baudRate`という変数名を選んだが、`baud_rate`でも`baudrate`でも問題ない。
しかし、途中に`-`等の記号が入ったり先頭に数字をつけたりすることはできないので
気をつけてほしい。ここらへんの規則の詳細は省く（ので気になる人は調べてほしい）
が**アルファベット大文字小文字であれば絶対大丈夫**ということさえ
覚えていれば問題ない。

**関数に限らず、データを直接扱える場面では変数も使うことができる**
ことと、**変数というのは値に名前をつけておくためのもの**、ということを
頭にいれておいてほしい。

