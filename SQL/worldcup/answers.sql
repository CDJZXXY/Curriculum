USE worldcup2014;

-- 1 各グループの中でFIFAランクが最も高い国と低い国のランキング番号を表示してください。
SELECT
  group_name AS グループ,
  MIN(ranking) AS ランキング最上位,
  MAX(ranking) AS ランキング最下位
FROM
  countries
GROUP BY
  group_name;

-- 2 全ゴールキーパーの平均身長、平均体重を表示してください
SELECT
  AVG(height) AS 平均身長,
  AVG(weight) AS 平均体重
FROM
  players
WHERE
  position = 'GK';

-- 3 各国の平均身長を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT
  c.name AS 国名,
  AVG(p.height) AS 平均身長
FROM
  countries c
  JOIN players p ON p.country_id = c.id
GROUP BY
  c.id,
  c.name
ORDER BY
  AVG(p.height) DESC;

-- 4 各国の平均身長を高い方から順に表示してください。ただし、FROM句はplayersテーブルとして、テーブル結合を使わず副問合せを用いてください。
SELECT
  (
    SELECT
      c.name
    FROM
      countries c
    WHERE
      p.country_id = c.id
  ) AS 国名,
  AVG(p.height) AS 平均身長
FROM
  players p
GROUP BY
  p.country_id
ORDER BY
  AVG(p.height) DESC;

-- 5 キックオフ日時と対戦国の国名をキックオフ日時の早いものから順に表示してください。
SELECT
  kickoff AS キックオフ日時,
  c1.name AS 国名1,
  c2.name AS 国名2
FROM
  pairings p
  LEFT JOIN countries c1 ON p.my_country_id = c1.id
  LEFT JOIN countries c2 ON p.enemy_country_id = c2.id
ORDER BY
  kickoff;

-- 6 すべての選手を対象として選手ごとの得点ランキングを表示してください。（SELECT句で副問合せを使うこと）
SELECT
  p.name AS 名前,
  p.position AS ポジション,
  p.club AS 所属クラブ,
  (
    SELECT
      COUNT(id)
    FROM
      goals g
    WHERE
      g.player_id = p.id
  ) AS ゴール数
FROM
  players p
ORDER BY
  ゴール数 DESC;

-- 7 すべての選手を対象として選手ごとの得点ランキングを表示してください。（テーブル結合を使うこと）
SELECT
  p.name AS 名前,
  p.position AS ポジション,
  p.club AS 所属クラブ,
  COUNT(g.id) AS ゴール数
FROM
  players p
  LEFT JOIN goals g ON g.player_id = p.id
GROUP BY
  p.id,
  p.name,
  p.position,
  p.club
ORDER BY
  ゴール数 DESC;

-- 8 各ポジションごとの総得点を表示してください。
SELECT
  p.position AS ポジション,
  COUNT(g.id) AS ゴール数
FROM
  players p
  LEFT JOIN goals g ON g.player_id = p.id
GROUP BY
  p.position
ORDER BY
  ゴール数 DESC;

-- 9 ワールドカップ開催当時（2014-06-13）の年齢をプレイヤー毎に表示する。
SELECT
  birth,
  TIMESTAMPDIFF (YEAR, birth, '2014-06-13') AS age,
  name,
  position
FROM
  players
ORDER BY
  age DESC;

-- 10 オウンゴールの回数を表示する
SELECT
  COUNT(g.goal_time)
FROM
  goals g
WHERE
  g.player_id IS NULL;

-- 11 各グループごとの総得点数を表示して下さい。
SELECT
  c.group_name,
  COUNT(g.id)
FROM
  goals g
  LEFT JOIN pairings p ON p.id = g.pairing_id
  LEFT JOIN countries c ON p.my_country_id = c.id
WHERE
  p.kickoff BETWEEN '2014-06-13 0:00:00' AND '2014-06-27 23:59:59'
GROUP BY
  c.group_name;

-- 12 日本VSコロンビア戦（pairings.id = 103）でのコロンビアの得点のゴール時間を表示してください
SELECT
  goal_time
FROM
  goals
WHERE
  pairing_id = 103;

-- 13 日本VSコロンビア戦の勝敗を表示して下さい。
SELECT
  c.name,
  COUNT(g.goal_time)
FROM
  goals g
  LEFT JOIN pairings p ON p.id = g.pairing_id
  LEFT JOIN countries c ON p.my_country_id = c.id
WHERE
  p.id = 103
  OR p.id = 39
GROUP BY
  c.name;

-- 14 グループCの各対戦毎にゴール数を表示してください。
SELECT
  p1.kickoff,
  c1.name AS my_country,
  c2.name AS enemy_country,
  c1.ranking AS my_ranking,
  c2.ranking AS enemy_ranking,
  COUNT(g1.id) AS my_goals
FROM
  pairings p1
  LEFT JOIN countries c1 ON c1.id = p1.my_country_id
  LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
  LEFT JOIN goals g1 ON p1.id = g1.pairing_id
WHERE
  c1.group_name = 'C'
  AND c2.group_name = 'C'
GROUP BY
  p1.kickoff,
  c1.name,
  c2.name,
  c1.ranking,
  c2.ranking
ORDER BY
  p1.kickoff,
  c1.ranking;

-- 15 グループCの各対戦毎にゴール数を表示してください。
SELECT
  p1.kickoff,
  c1.name AS my_country,
  c2.name AS enemy_country,
  c1.ranking AS my_ranking,
  c2.ranking AS enemy_ranking,
  (
    SELECT
      COUNT(g1.id)
    FROM
      goals g1
    WHERE
      p1.id = g1.pairing_id
  ) AS my_goals
FROM
  pairings p1
  LEFT JOIN countries c1 ON c1.id = p1.my_country_id
  LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
WHERE
  c1.group_name = 'C'
  AND c2.group_name = 'C'
ORDER BY
  p1.kickoff,
  c1.ranking;

-- 16 グループCの各対戦毎にゴール数を表示してください。
SELECT
  p1.kickoff,
  c1.name AS my_country,
  c2.name AS enemy_country,
  c1.ranking AS my_ranking,
  c2.ranking AS enemy_ranking,
  (
    SELECT
      COUNT(g1.id)
    FROM
      goals g1
    WHERE
      p1.id = g1.pairing_id
  ) AS my_goals,
  (
    SELECT
      COUNT(g2.id)
    FROM
      goals g2
      LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
    WHERE
      p2.my_country_id = p1.enemy_country_id
      AND p2.enemy_country_id = p1.my_country_id
  ) AS enemy_goals
FROM
  pairings p1
  LEFT JOIN countries c1 ON c1.id = p1.my_country_id
  LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
WHERE
  c1.group_name = 'C'
  AND c2.group_name = 'C'
ORDER BY
  p1.kickoff,
  c1.ranking;

-- 17 問題16の結果に得失点差を追加してください。
SELECT
  p1.kickoff,
  c1.name AS my_country,
  c2.name AS enemy_country,
  c1.ranking AS my_ranking,
  c2.ranking AS enemy_ranking,
  (
    SELECT
      COUNT(g1.id)
    FROM
      goals g1
    WHERE
      p1.id = g1.pairing_id
  ) AS my_goals,
  (
    SELECT
      COUNT(g2.id)
    FROM
      goals g2
      LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
    WHERE
      p2.my_country_id = p1.enemy_country_id
      AND p2.enemy_country_id = p1.my_country_id
  ) AS enemy_goals,
  (
    SELECT
      COUNT(g1.id)
    FROM
      goals g1
    WHERE
      p1.id = g1.pairing_id
  ) - (
    SELECT
      COUNT(g2.id)
    FROM
      goals g2
      LEFT JOIN pairings p2 ON p2.id = g2.pairing_id
    WHERE
      p2.my_country_id = p1.enemy_country_id
      AND p2.enemy_country_id = p1.my_country_id
  ) AS goal_diff
FROM
  pairings p1
  LEFT JOIN countries c1 ON c1.id = p1.my_country_id
  LEFT JOIN countries c2 ON c2.id = p1.enemy_country_id
WHERE
  c1.group_name = 'C'
  AND c2.group_name = 'C'
ORDER BY
  p1.kickoff,
  c1.ranking;

-- 18 ブラジル（my_country_id = 1）対クロアチア（enemy_country_id = 4）戦のキックオフ時間（現地時間）を表示してください。
SELECT
  p.kickoff,
  DATE_ADD (p.kickoff, INTERVAL '-12' HOUR) AS kickoff_jp
FROM
  pairings p
WHERE
  p.my_country_id = 1
  AND p.enemy_country_id = 4;

-- 19 年齢ごとの選手数を表示してください。
SELECT
  TIMESTAMPDIFF (YEAR, birth, '2014-06-13') AS age,
  COUNT(id) AS player_count
FROM
  players
GROUP BY
  age;

-- 20 年齢ごとの選手数を表示してください。ただし、10歳毎に合算して表示してください。
SELECT
  FLOOR(TIMESTAMPDIFF (YEAR, birth, '2014-06-13') / 10) * 10 AS age,
  COUNT(id) AS player_count
FROM
  players
GROUP BY
  age;

-- 21 年齢ごとの選手数を表示してください。ただし、5歳毎に合算して表示してください。
SELECT
  FLOOR(TIMESTAMPDIFF (YEAR, birth, '2014-06-13') / 5) * 5 AS age,
  COUNT(id) AS player_count
FROM
  players
GROUP BY
  age;

-- 22 以下の条件でSQLを作成し、抽出された結果をもとにどんなことが分析できるか考えてみてください。
SELECT
  FLOOR(TIMESTAMPDIFF (YEAR, birth, '2014-06-13') / 5) * 5 AS age,
  position,
  COUNT(id) AS player_count,
  AVG(height),
  AVG(weight)
FROM
  players
GROUP BY
  age,
  position
ORDER BY
  age,
  position;

-- 23 身長の高い選手ベスト5を抽出し、以下の項目を表示してください。
SELECT
  name,
  height,
  weight
FROM
  players
ORDER BY
  height DESC
LIMIT
  5;

-- 24 身長の高い選手6位～20位を抽出し、以下の項目を表示してください。
SELECT
  name,
  height,
  weight
FROM
  players
ORDER BY
  height DESC
LIMIT
  5, 15;

-- 25 全選手の以下のデータを抽出してください。–射影
SELECT
  uniform_num,
  name,
  club
FROM
  players;

-- 26 グループCに所属する国をすべて抽出してください。–選択（＝）
SELECT
  *
FROM
  countries
WHERE
  group_name = 'C';

-- 27 グループC以外に所属する国をすべて抽出してください。–選択（！＝）
SELECT
  *
FROM
  countries
WHERE
  group_name != 'C';

-- 28 2016年1月13日現在で40歳以上の選手を抽出してください。（誕生日の人を含めてください。）–選択（＞＝、＜＝）
SELECT
  *
FROM
  players
WHERE
  TIMESTAMPDIFF (YEAR, birth, '2016-01-13') >= 40;

-- 29 身長が170cm未満の選手を抽出してください。–選択（＞、＜）
SELECT
  *
FROM
  players
WHERE
  height < 170;

-- 30 FIFAランクが日本（46位）の前後10位に該当する国（36位～56位）を抽出してください。ただし、BETWEEN句を用いてください。–選択（BETWEEN）
SELECT
  *
FROM
  countries
WHERE
  ranking BETWEEN 36 AND 56;

-- 31 選手のポジションがGK、DF、MFに該当する選手をすべて抽出してください。ただし、IN句を用いてください。–選択（IN）
SELECT
  *
FROM
  players
WHERE
  position IN ('GK', 'DF', 'MF');

-- 32 オウンゴールとなったゴールを抽出してください。goalsテーブルのplayer_idカラムにNULLが格納されているデータがオウンゴールを表しています。–選択（IS NULL）
SELECT
  *
FROM
  goals
WHERE
  player_id IS NULL;

-- 33 オウンゴール以外のゴールを抽出してください。goalsテーブルのplayer_idカラムにNULLが格納されているデータがオウンゴールを表しています。–選択（IS NOT NULL）
SELECT
  *
FROM
  goals
WHERE
  player_id IS NOT NULL;

-- 34 名前の末尾が「ニョ」で終わるプレイヤーを抽出してください。–選択（LIKE前方or後方）
SELECT
  *
FROM
  players
WHERE
  name LIKE '%ニョ';

-- 35 名前の中に「ニョ」が含まれるプレイヤーを抽出してください。–選択（LIKE前方後方一致）
SELECT
  *
FROM
  players
WHERE
  name LIKE '%ニョ%';

-- 36 グループA以外に所属する国をすべて抽出してください。ただし、「!=」や「<>」を使わずに、「NOT」を使用してください。–選択（NOT）
SELECT
  *
FROM
  countries
WHERE
  NOT group_name = 'A';

-- 37 全選手の中でBMI値が20台の選手を抽出してください。BMIは以下の式で求めることができます。–選択（AND)
SELECT
  *
FROM
  players
WHERE
  weight / POW (height / 100, 2) >= 20
  AND weight / POW (height / 100, 2) < 21;

-- 38 全選手の中から小柄な選手（身長が165cm未満か、60kg未満）を抽出してください。–選択（OR)
SELECT
  *
FROM
  players
WHERE
  height < 165
  OR weight < 60;

-- 39 FWかMFの中で170未満の選手を抽出してください。ただし、ORとANDを使用してください。–選択（AND、ORの組み合わせ）
SELECT
  *
FROM
  players
WHERE
  (
    position = 'FW'
    OR POSITION = 'MF'
  )
  AND height < 170;

-- 40 ポジションの一覧を表示してください。グループ化は使用しないでください。–DISTINCT
SELECT DISTINCT
  position
FROM
  players;

-- 41 全選手の身長と体重を足した値を表示してください。合わせて選手の名前、選手の所属クラブも表示してください。–算術演算子（SELECT句）
SELECT
  name,
  club,
  height + weight
FROM
  players;

-- 42 選手名とポジションを以下の形式で出力してください。シングルクォートに注意してください。–文字列結合、エスケープシーケンス
SELECT
  CONCAT (name, '選手のポジションは\'', position, '\'です')
FROM
  players;

-- 43 全選手の身長と体重を足した値をカラム名「体力指数」として表示してください。合わせて選手の名前、選手の所属クラブも表示してください。–列見出し
SELECT
  name,
  club,
  height + weight AS 体力指数
FROM
  players;

-- 44 FIFAランクの高い国から順にすべての国名を表示してください。–ソート（単一カラム）
SELECT
  *
FROM
  countries
ORDER BY
  ranking;

-- 45 全ての選手を年齢の低い順に表示してください。なお、年齢を計算する必要はありません。–ソート（降順）
SELECT
  *
FROM
  players
ORDER BY
  birth DESC;

-- 46 全ての選手を身長の大きい順に表示してください。同じ身長の選手は体重の重い順に表示してください。–ソート（複数カラム）
SELECT
  *
FROM
  players
ORDER BY
  height DESC,
  weight DESC;

-- 47 全ての選手のポジションの1文字目（GKであればG、FWであればF）を出力してください。–単一行関数（文字列関数）
SELECT
  id,
  country_id,
  uniform_num,
  SUBSTRING(position, 1, 1),
  name
FROM
  players;

-- 48 出場国の国名が長いものから順に出力してください。–単一行関数（文字列関数）
SELECT
  name,
  LENGTH (name)
FROM
  countries
ORDER BY
  LENGTH (name) DESC;

-- 49 全選手の誕生日を「2017年04月30日」のフォーマットで出力してください。–単一行関数（DATE_FORMAT）
SELECT
  name,
  DATE_FORMAT (birth, '%Y年%m月%d日') AS birthday
FROM
  players;

-- 50 全てのゴール情報を出力してください。ただし、オウンゴール（player_idがNULLのデータ）はIFNULL関数を使用してplayer_idを「9999」と表示してください。–単一行関数（IFNULL）
SELECT
  IFNULL (player_id, 9999) as player_id,
  goal_time
FROM
  goals;

-- 51 全てのゴール情報を出力してください。ただし、オウンゴール（player_idがNULLのデータ）はCASE関数を使用してplayer_idを「9999」と表示してください。–単一行関数（CASE）
SELECT
  CASE
    WHEN player_id IS NULL THEN 9999
    ELSE player_id
  END AS player_id,
  goal_time
FROM
  goals;

-- 52 全ての選手の平均身長、平均体重を表示してください。–グループ関数（AVG）
SELECT
  AVG(height) AS '平均身長',
  AVG(weight) AS '平均体重'
FROM
  players;

-- 53 日本の選手（player_idが714から736）が上げたゴール数を表示してください。–グループ関数（COUNT）
SELECT
  COUNT(id) AS '日本のゴール数'
FROM
  goals
WHERE
  player_id BETWEEN 714 AND 736;

-- 54 オウンゴール（player_idがNULL）以外の総ゴール数を表示してください。ただし、WHERE句は使用しないでください。–グループ関数（COUNT）
SELECT
  COUNT(player_id) AS 'オウンゴール以外のゴール数'
FROM
  goals;

-- 55 全ての選手の中で最も高い身長と、最も重い体重を表示してください。–グループ関数（MAX）
SELECT
  MAX(height) AS '最大身長',
  MAX(weight) AS '最大体重'
FROM
  players;

-- 56 AグループのFIFAランク最上位を表示してください。–グループ関数（MIN）
SELECT
  MIN(ranking) AS AグループのFIFAランク最上位
FROM
  countries
WHERE
  group_name = 'A';

-- 57 CグループのFIFAランクの合計値を表示してください。–グループ関数（SUM）
SELECT
  SUM(ranking) AS CグループのFIFAランクの合計値
FROM
  countries
WHERE
  group_name = 'C';

-- 58 全ての選手の所属国と名前、背番号を表示してください。–内部結合（INNER JOIN）
SELECT
  c.name,
  p.name,
  p.uniform_num
FROM
  players p
  LEFT JOIN countries c ON c.id = p.country_id;

-- 59 全ての試合の国名と選手名、得点時間を表示してください。オウンゴール（player_idがNULL）は表示しないでください。–内部結合（INNER JOIN）
SELECT
  c.name,
  p.name,
  g.goal_time
FROM
  goals g
  JOIN players p ON p.id = g.player_id
  JOIN countries c ON c.id = p.country_id;

-- 60 全ての試合のゴール時間と選手名を表示してください。左側外部結合を使用してオウンゴール（player_idがNULL）も表示してください。外部結合（LEFT JOIN）
SELECT
  g.goal_time,
  p.uniform_num,
  p.position,
  p.name
FROM
  goals g
  LEFT JOIN players p ON p.id = g.player_id;

-- 61 全ての試合のゴール時間と選手名を表示してください。右側外部結合を使用してオウンゴール（player_idがNULL）も表示してください。外部結合（RIGHT JOIN）
SELECT
  g.goal_time,
  p.uniform_num,
  p.position,
  p.name
FROM
  players p
  RIGHT JOIN goals g ON g.player_id = p.id;

-- 62 全ての試合のゴール時間と選手名、国名を表示してください。また、オウンゴール（player_idがNULL）も表示してください。–2つ以上の外部結合
SELECT
  c.name AS country_name,
  g.goal_time,
  p.position,
  p.name AS player_name
FROM
  goals g
  LEFT JOIN players p ON p.id = g.player_id
  LEFT JOIN countries c ON c.id = p.country_id;

-- 63 全ての試合のキックオフ時間と対戦国の国名を表示してください。–自己結合
SELECT
  p.kickoff,
  c1.name AS my_country_id,
  c2.name AS enemy_country_id
FROM
  pairings p
  JOIN countries c1 ON c1.id = p.my_country_id
  JOIN countries c2 ON c2.id = p.enemy_country_id;

-- 64 全てのゴール時間と得点を上げたプレイヤー名を表示してください。オウンゴールは表示しないでください。ただし、結合は使わずに副問合せを用いてください。–副問合せ（SELECT句）
SELECT
  g.id,
  g.goal_time,
  (
    SELECT
      p.name
    FROM
      players p
    WHERE
      p.id = g.player_id
  ) AS player_name
FROM
  goals g
WHERE
  g.player_id IS NOT NULL;

-- 65 全てのゴール時間と得点を上げたプレイヤー名を表示してください。オウンゴールは表示しないでください。ただし、副問合せは使わずに、結合を用いてください。–結合と副問合せ（SELECT句）
SELECT
  g.id,
  g.goal_time,
  p.name
FROM
  goals g
  JOIN players p ON p.id = g.player_id;

-- 66 各ポジションごと（GK、FWなど）に最も身長と、その選手名、所属クラブを表示してください。ただし、FROM句に副問合せを使用してください。–副問合せ（FROM句）
SELECT
  p1.position,
  p1.最大身長,
  p2.name,
  p2.club
FROM
  (
    SELECT
      position,
      MAX(height) AS 最大身長
    FROM
      players
    GROUP BY
      position
  ) AS p1
  LEFT JOIN players p2 ON p2.height = p1.最大身長
  AND p2.position = p1.position;

SELECT
  p1.position,
  p1.height,
  p1.name,
  p1.club
FROM
  players p1
WHERE
  p1.height = (
    SELECT
      MAX(p2.height)
    FROM
      players p2
    WHERE
      p2.position = p1.position
  );

-- 67 各ポジションごと（GK、FWなど）に最も身長と、その選手名を表示してください。ただし、SELECT句に副問合せを使用してください。–副問合せ（SELECT句）
SELECT
  p1.position,
  MAX(p1.height) AS 最大身長,
  (
    SELECT
      p2.name
    FROM
      players p2
    WHERE
      p2.position = p1.position
      AND p2.height = MAX(p1.height)
  ) AS 名前
FROM
  players p1
GROUP BY
  p1.position;

-- 68 全選手の平均身長より低い選手をすべて抽出してください。表示する列は、背番号、ポジション、名前、身長としてください。–副問合せ（WHERE句）
SELECT
  uniform_num,
  position,
  name,
  height
FROM
  players
WHERE
  height < (
    SELECT
      AVG(height)
    FROM
      players
  );

-- 69 各グループの最上位と最下位を表示し、その差が50より大きいグループを抽出してください。–HAVING句
SELECT
  group_name,
  MAX(ranking),
  MIN(ranking)
FROM
  countries
GROUP BY
  group_name
HAVING
  MAX(ranking) - MIN(ranking) > 50;

-- 70 1980年生まれと、1981年生まれの選手が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。–集合演算子（UNION）
SELECT
  '1980' AS '誕生年',
  COUNT(id)
FROM
  players
WHERE
  birth BETWEEN '1980-1-1' AND '1980-12-31'
UNION
SELECT
  '1981',
  COUNT(id)
FROM
  players
WHERE
  birth BETWEEN '1981-1-1' AND '1981-12-31';

-- 71 身長が195㎝より大きいか、体重が95kgより大きい選手を抽出してください。ただし、以下の画像のように、どちらの条件にも合致する場合には2件分のデータとして抽出してください。また、結果はidの昇順としてください。集合演算子（UNION ALL）
SELECT
  id,
  position,
  name,
  height,
  weight
FROM
  players
WHERE
  height > 195
UNION ALL
SELECT
  id,
  position,
  name,
  height,
  weight
FROM
  players
WHERE
  weight > 95
ORDER BY
  id;

-- 72 Viewは仮想テーブルなので、その中にデータは存在しません。それではViewの実態は何でしょう？Viewとは
-- A: Viewの実態はSELECT文です。
-- 73 以下の○○○に当てはまる用語を解答してください。Viewを作成するには○○○文を使用します。作成したViewは実テーブルを参照するのと同じように○○○文を利用します。Viewの作成
-- A: Viewを作成するにはCREATE VIEW文を使用します。作成したViewは実テーブルを参照するのと同じようにSELECT文を利用します。
-- 74 作成したViewを変更するためには以下のうちどの文を使用すればよいでしょうか？・UPDATE VIEW文・ADD VIEW文・ALTER VIEW文・SELECT VIEW文Viewの変更・更新
-- A: ALTER VIEW文
-- 75 Viewを削除する文を以下から選択してください。・DELETE VIEW文・ALTER VIEW文・RESET VIEW文・DROP VIEW文Viewの削除
-- A: DROP VIEW文