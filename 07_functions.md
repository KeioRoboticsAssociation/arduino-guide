## 関数

リファクタリングの余地はまだ少し残っている。
これまで、値に名前をつけてわかりやすくしたいときは変数を使ってきたが、
コードの塊に名前をつけてわかりやすくしたいときはどうすればいいのか？
最初に少しふれた関数というのを使えばよい。

例えば、整数を渡すと偶数か奇数かを出力する関数、`showNumber`を使って上の
例をリファクタリングすると次のようになる。

```cpp
int count = 1;
void setup() {
  Serial.begin(9600);
}
void showNumber(int number) {
  Serial.print(number);
  if (number % 2 == 0) {
    Serial.print(" is an even number.\n");
  } else {
    Serial.print(" is an odd number.\n");
  }
}
void loop() {
  showNumber(count);
  count = count + 1;
  delay(100);
}
```

そう、これまで書いてきた`setup()`と`loop()`は実は関数だったのだ！
`void`の部分はとりあえず飛ばして、`showNumber()`の括弧に入っている`int number`に
注目しよう。`setup()`と`loop()`は空な一方`showNumber()`に入っている、
変数宣言に似ているこれは**引数**と呼ばれ、関数に渡すことができるデータを
指定している。そして、関数が呼び出されたときに渡されたデータは引数で
与えられている変数に代入される。例えば`showNumber(count);`の
行では`showNumber()`の中身が実行される直前に裏で`int number = count;`が
実行されるというイメージだ。

数学でいう関数のように、計算結果を返すような関数も定義できる。
`count % 2 == 0`が偶数かどうかを判定しているのをわかりやすくするために
関数にしてしまおう。

```cpp
int count = 1;
void setup() {
  Serial.begin(9600);
}
bool isEven(int number) {
  return number % 2 == 0;
}
void showNumber(int number) {
  Serial.print(number);
  if (isEven(number)) {
    Serial.print(" is an even number.\n");
  } else {
    Serial.print(" is an odd number.\n");
  }
}
void loop() {
  showNumber(count);
  count = count + 1;
  delay(100);
}
```

他の関数では`void`となっている部分が`bool`となったことがわかる。
これは、関数が`bool`型の値を返すことを意味している。
また、関数内で`return`文が出てくると関数が呼び出された場所に実行が戻り、
`return`の後に来る値が関数から返される値（**戻り値**）になる。
`void`は「なにもない」ことを表す型であり、そういう関数の場合は`return;`と
だけ書くか関数の中身の実行が全部済むと実行が呼び出し元に戻る。

