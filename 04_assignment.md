## 代入

しかし、変数はただ値に名前をつけておくためのものという存在ではない。
中身を**代入**により変更することができる。
今度は、1から3までの数字を出力するプログラムを考えてみよう。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 1;
  Serial.print(count);
  count = 2;
  Serial.print(count);
  count = 3;
  Serial.print(count);
}
void loop() {
}
```

これを実行すると次の出力が得られる。

```
1
2
3
```

`Serial.print`に渡される`count`変数が毎回変わっていることが見て取れる。
代入は`= 1`、`= 2`、そして`= 3`の行で行われている。最初のやつは
変数の宣言だったんじゃないのか、と思うかもしれない。それも間違ってはいない。
ではその行は何をしているのかというと、変数の宣言と値の代入の両方を行っている。
（これを変数の**初期化**と呼ぶ）逆に、変数の宣言時には必ずしも代入を行う
必要はなく、例えば`int count = 1;`は次のように書いても問題ない。
ただし、値を代入されていない変数を使おうとする（例えば`Serial.print`に渡す）と
エラーが起こることに注意してほしい。

```cpp
int count;
count = 0;
```

また、先ほどのコードは、次のようにも書ける。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 1;
  Serial.print(count);
  count = count + 1;
  Serial.print(count);
  count = count + 1;
  Serial.print(count);
}
void loop() {
}
```

`count = count + 1;`の行は数学的にあきらかにおかしいじゃないか、
と思ったかもしれない。確かにこれは数学ではありえない話だ。
しかしこれはプログラミングだ。代入の仕組みを踏まえて、これは何をやっているか
順を追って考えてみよう。前の例で変数に値を代入したことを思い出してほしい。
`count = 0;`という具合に変数`count`に値`0`を代入しているわけだが、
ここで値を入れていたところに別な変数を入れることもできる。
**関数に限らず、データを直接扱える場面では変数も使うことができる**
話を思い出してほしい。例えば、次のようなコードを書くことも可能というわけだ。

```cpp
int var1 = 1;
int var2 = 2;
var1 = var2;
```

これを実行したあとの変数`var1`、`var2`の値を予想できるだろうか？
不安がある人は`Serial.print`にそれぞれお渡すコードを書いて確かめよう。

そして、ここで`int`（整数型）での四則演算の仕方を紹介しよう。
足し算は`+`、引き算は`-`、掛け算は`*`、割り算は`/`で行う。
算数と同様に掛け算割り算が先に計算されて、次に足し算引き算が計算される。
そして、先に計算してほしい部分は括弧`()`で囲む。

```cpp
void start() {
  Serial.begin(9600);
  int result = (1 + 5) * 9 + 3 * -4;
  Serial.print(result);
}
void loop() {
}
```

例えば、これを実行すると`42`が得られる。これは次のようにも書ける。

```cpp
void start() {
  Serial.begin(9600);
  Serial.print((1 + 5) * 9 + 3 * -4);
}
void loop() {
}
```

つまり、計算も変数や値と同じように直接関数に渡すことができるわけだ。
そして、値が使える場面では変数も使えるから次のようなコードもアリだ。

```cpp
void start() {
  Serial.begin(9600);
  int ringoPrice = 100;
  int mikanPrice = 80;
  int takashiSaifu = 600;
  int nokoriMoney = takashiSaifu - ringoPrice * 5 - mikanPrice * 2;
  Serial.print(nokoriMoney);
}
void loop() {
}
```

実行してみよう。たかしくんは負債を抱えてしまったようだ。
逆にりんごを5個買ったらいくつみかんを買えるだろうか？
これもプログラムに計算を任せよう。

```cpp
void start() {
  Serial.begin(9600);
  int ringoPrice = 100;
  int mikanPrice = 80;
  int takashiSaifu = 600;
  int mikanKosuu = (takashiSaifu - ringoPrice * 5) / mikanPrice;
  Serial.print(nokoriMoney);
}
void loop() {
}
```

これを実行するとたかし君は買うみかんを1つだけ買えば、負債を抱えずに済むことが
わかる。しかし、ぴったり`1`と表示されたことに驚くかもしれない。
手で計算する限り、`(600 - 100 * 5) / 80`は1.25になるはずなのに...
と考えるかもしれない。ここで使われている変数の「型」に注目してほしい。
`int`は整数型を意味する。実は、整数同士の割り算結果は整数になるように
繰り下げられる。じっさいたかし君が買えるみかんの数は整数になるように、
整数型の変数同士の計算からは整数しか得られないし、整数型の変数には整数しか
代入できない。

これでさっきのコードの意味を理解する準備ができた。もう一度見てみよう。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 1;
  Serial.print(count);
  count = count + 1;
  Serial.print(count);
  count = count + 1;
  Serial.print(count);
}
void loop() {
}
```

まず、一つ目の`count = count + 1;`に注目しよう。
代入文だから、右辺の計算結果が左辺にある変数に入ることがわかる。
そこで、`count + 1`はどういう値になるかというと、`int count = 1`で変数
`count`が`1`に初期化されていることからこの時点では`count`には`1`が
入っていることがわかる。だから`count + 1`の計算結果は`2`になる。
そして、計算結果が`count`に代入されるため`count`の値は`2`になり次の行の
`Serial.print`で出力される。つまり、`count = count + 1;`というのは
`count`に入っている値を一つ増やしてくれるというわけだ。
すると、先ほどのコードを次のようにも書いても同じ結果が得られることが
わかる。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 0;
  count = count + 1;
  Serial.print(count);
  count = count + 1;
  Serial.print(count);
  count = count + 1;
  Serial.print(count);
}
void loop() {
}
```

