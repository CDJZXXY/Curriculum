#!/bin/zsh

date "+%Y/%m/%d %H:%M"

# コーディングルールをチェック
npm run lint

# テストパターン1から5の出力をチェック
for i in 1 2 3 4 5
do
  cat ./input/input${i} | ../node_modules/.bin/ts-node index.ts > ./output

  # diffで差分がなければOKを表示
  RESULT=$(diff -q ./expected/expected${i} ./output);
  if [ "$RESULT" = "" ]; then
      echo "テストパターン${i}: OK！"
  else
      echo "テストパターン${i}: NO！"
  fi
done
rm ./output
