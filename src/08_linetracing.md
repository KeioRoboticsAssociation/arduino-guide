## ライントレースへ

プログラミングの基礎を身に着けたところで、文字を単調に出力するだけの
面白みに書けるプログラムを卒業してマイコンを活用したプログラムを書いてみよう。
まずは、ラインセンサからデータを受け取ってみよう。
Arduinoにつなげたラインセンサーは光の反射度合いで電圧が上がったり下がったりする。
マイコンについている**A/D変換**という機能を使うとこの電圧の高低を
プログラム内で数値として扱うことができる。
具体的には、`analogRead()`という関数に読み込みたいピンを指定すると
0〜1023の整数として返ってくる。
早速受け取った数値をそのまま表示するプログラムを書いてみよう。

```cpp
void setup() {
  Serial.begin(9600);
}
void loop() {
  int right = analogRead(A0);
  Serial.print(right);
  delay(100);
}
```

`A0`というのは右のラインセンサを繋いだピンであることをわかりやすくするために
`right`という変数に代入した。これを実行した上で、ラインセンサの前で
指を行き来させると数値が変わっていくのを見て取れるはずだ。

次は、しきい値に応じて`white`か`black`と出力するように改変してみよう。

```cpp
void setup() {
  Serial.begin(9600);
}
void loop() {
  int right = analogRead(A0);
  Serial.print(right);
  if (right < 500) {
    Serial.print(": white\n");
  } else {
    Serial.print(": black\n");
  }
  delay(100);
}
```

`500`でうまく判定できていないようだったら適宜調整してみよう。
せっかくだから黒と判定している問はついでにLEDを光らせてみよう。

マイコンは電圧をA/D変換により読み取ること以外にも、
電圧を0/1的に検出したり（ボタンが押されたかどうかの判定などにつかえる）
電圧をかけたり（LEDのON/OFFの制御などにつかえる）することができる。
電圧の検出は`digitalRead`、電圧をかけるには`digitalWrite`を使う。
Arduinoの所定のピンは両方の機能を備えているため、
どちらを使うかを設定する必要がある。`Serial.begin`と似たような、初期設定だ。
具体的には、`setup()`で`pinMode`関数にLED点灯用のピン（LED_BUILTIN）と
電圧をかける旨（OUTPUT）を渡す。そして、黒と判定されたときは
`digitalWrite()`関数に扱うピン（LED_BUILTIN）と電圧をかけて（HIGH）LEDを点灯
させ、白と判定されたときは電圧を下げて（LOW）LEDを消灯させる。
`Serial.print`に加えてLEDで白黒を示するコードを次に示す。

```cpp
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
}
void loop() {
  int right = analogRead(A0);
  Serial.print(right);
  if (right < 500) {
    digitalWrite(LED_BUILTIN, LOW);
    Serial.print(": white\n");
  } else {
    digitalWrite(LED_BUILTIN, HIGH);
    Serial.print(": black\n");
  }
  delay(100);
}
```

これでライントレーサに必要な関数はすべて網羅した。
後はこれらをうまく組み合わせると次のライントレーサプログラムが出来上がる。

```cpp
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH); // turn the LED on with voltage level HIGH
  int speedHigh = 64;
  int speedLow = 0;
  int right = analogRead(A0);
  int left = analogRead(A1);
  if (left < right * 1.5) {
    analogWrite(6, speedHigh);
  } else {
    analogWrite(6, speedLow);
  }
  if (right < left * 1.5) {
    analogWrite(5, speedHigh);
  } else {
    analogWrite(5, speedLow);
  }
  Serial.print("right: ");
  Serial.print(right);
  Serial.print("\n");
  Serial.print("left: ");
  Serial.print(left);
  Serial.print("\n");
  
  digitalWrite(LED_BUILTIN, LOW); // turn the LED off with voltage level LOW
  delay(1); // wait for a millisecond
}
```

