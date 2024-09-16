-- データベースの作成
CREATE DATABASE IF NOT EXISTS LikeSystem;

USE LikeSystem;

-- usersテーブルの作成
CREATE TABLE
  IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE
  );

-- postsテーブルの作成
CREATE TABLE
  IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    artical TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
  );

-- likesテーブルの作成（中間テーブル）
CREATE TABLE
  IF NOT EXISTS likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE
  );

-- テストデータの挿入
-- usersテーブルに3人のユーザーを追加
INSERT INTO
  users (username)
VALUES
  ('Alice'),
  ('Bob'),
  ('Charlie');

-- postsテーブルに3つの投稿を追加
INSERT INTO
  posts (used_id, artical)
VALUES
  (1, 'Post 1'),
  (1, 'Post 2'),
  (2, 'Post 3'),
  (3, 'Post 3');
