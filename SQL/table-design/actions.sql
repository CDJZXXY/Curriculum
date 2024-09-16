USE LikeSystem;

-- 1. likesテーブルにデータを追加（ユーザーがいいねを押した時の挙動）
-- Alice が Post 1 にいいね
INSERT INTO
  likes (user_id, post_id)
VALUES
  (1, 1);

-- Bob が Post 1 にいいね
INSERT INTO
  likes (user_id, post_id)
VALUES
  (2, 1);

-- Alice が Post 2 にいいね
INSERT INTO
  likes (user_id, post_id)
VALUES
  (1, 2);

-- 動作確認のため、現在のlikesテーブルの内容を表示
SELECT
  *
FROM
  likes;

-- 2. 重複するデータの追加を試みる（同じユーザーが同じ投稿に再びいいねを押す場合の挙動）
-- Alice が Post 1 に再度いいね（ここでエラーが出るべき）
INSERT INTO
  likes (user_id, post_id)
VALUES
  (1, 1);

-- ↑このクエリはエラーになるはずです。PRIMARY KEY (user_id, post_id) によって重複が防がれます。