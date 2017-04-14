## if・else文

この`bool`型の値は他の場面でも使える。
例えば、単純に条件が一致していたら一度だけ実行したいときの条件分岐のときだ。
1からひたすら偶数を数え上げるプログラムを考えてみよう。
愚直に書くと、このようになる。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 1;
  while (true) {
    if (count % 2 == 0) {
      Serial.print(count);
      Serial.print(" is an even number.\n");
    }
    count = count + 1;
    delay(100);
  }
}
void loop() {
}
```

今回新しく出てきた`if`文に注目して欲しい。
`if`の後に`(count % 2 == 0)`という条件式が来ているが、
これは`%`で`count`を2で割ったあまりを取得し、`==`で0と一致するか調べている。
つまり、偶数かどうかを判定しているわけだ。
そして、その`bool`値が`true`になると`{}`の中身が実行され、画面に

```
2 is an even number.
```

のように出力される。今度は偶数に加えて奇数も出力して欲しいとしよう。
最初の`if`文の後にもう一つ`count % 2 == 1`や`count % 2 != 0`のような条件を
持った`if`文を設置するのもでも実現できるが、基本的に`if`文の条件が
当てはまらなかった場合にも何かを実行したいときは`else`文を使う。
`else`文を使って奇数も数え上げるようにしたコードは次のようになる。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 1;
  while (true) {
    if (count % 2 == 0) {
      Serial.print(count);
      Serial.print(" is an even number.\n");
    } else {
      Serial.print(count);
      Serial.print(" is an odd number.\n");
    }
    count = count + 1;
    delay(100);
  }
}
void loop() {
}
```

すると、次のような出力が得られる。

```
1 is an odd number.
2 is an even number.
3 is an odd number.
・
・
・
```

先ほどから「なぜ`loop()`の中に無限ループの中身をいれないのか？」と
思っているかもしれない。愚直に次のように無限ループの中身を
`loop()`の中に入れると実はコンパイルが失敗してしまう。

```cpp
void setup() {
  Serial.begin(9600);
  int count = 1;
}
void loop() {
  if (count % 2 == 0) {
    Serial.print(count);
    Serial.print(" is an even number.\n");
  } else {
    Serial.print(count);
    Serial.print(" is an odd number.\n");
  }
  count = count + 1;
  delay(100);
}
```

```
Arduino: 1.6.12 (Linux), Board: "Arduino Nano, ATmega168"

/home/delta/Downloads/linetracer/linetracer.ino: In function 'void loop()':
linetracer:6: error: 'count' was not declared in this scope
   if (count % 2 == 0) {
       ^
linetracer:13: error: 'count' was not declared in this scope
   count = count + 1;
   ^
exit status 1
'count' was not declared in this scope

This report would have more information with
"Show verbose output during compilation"
option enabled in File -> Preferences.
```

どうやら`loop()`内で変数`count`は宣言されていないことになっているらしい。
実は、変数宣言の効果が及ぶ範囲は宣言を囲む`{}`までに限られる。
この「変数宣言の効果が及ぶ範囲」を**スコープ**と呼ぶ。
したがって、`setup()`内で宣言された変数は`setup()`内でしか使えないわけだ。
次のように`int count = 1;`を`loop()`に入れればいいと思うかもしれない。

```cpp
void setup() {
  Serial.begin(9600);
}
void loop() {
  int count = 1;
  if (count % 2 == 0) {
    Serial.print(count);
    Serial.print(" is an even number.\n");
  } else {
    Serial.print(count);
    Serial.print(" is an odd number.\n");
  }
  count = count + 1;
  delay(100);
}
```

しかし、これを実行すると次のような出力が得られる。

```
1 is an odd number.
1 is an odd number.
1 is an odd number.
・
・
・
```

これは何がおきているかというと、`loop()`が実行する度に新しい変数`count`が
宣言・初期化されている。つまり、毎回`count`の中身は`1`として
扱われるようになってしまう。これは明らかに意図した動作ではない。

では、どうすればよいか。
変数宣言・初期化を`setup()`、`loop()`の外でやればよい。
つまり、こういうことだ。

```cpp
int count = 1;
void setup() {
  Serial.begin(9600);
}
void loop() {
  if (count % 2 == 0) {
    Serial.print(count);
    Serial.print(" is an even number.\n");
  } else {
    Serial.print(count);
    Serial.print(" is an odd number.\n");
  }
  count = count + 1;
  delay(100);
}
```

こうすると、`count`変数のスコープは`setup()`全体を含むようになり、
問題なくコンパイルできるようになる。
この**`setup()`にも`loop()`にも属さない場所での命令は変数宣言・初期化以外
認められず、実行のタイミングとしては`setup()`よりさらに前**だということを
覚えておこう。

ここまでしてきた、無駄な部分をまとめたり、読みやすくなるように書き換えたりする
作業を**リファクタリング**と呼ぶ。例えば`if`文を見ると、条件が成立しても
しなくても`Serial.print(count);`は実行される。これを次のように
リファクタリングしたほうが簡潔に表現できる。

```cpp
int count = 1;
void setup() {
  Serial.begin(9600);
}
void loop() {
  Serial.print(count);
  if (count % 2 == 0) {
    Serial.print(" is an even number.\n");
  } else {
    Serial.print(" is an odd number.\n");
  }
  count = count + 1;
  delay(100);
}
```

