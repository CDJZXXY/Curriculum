import * as readline from 'readline';

const inputs: readline.Interface = readline.createInterface({
  input: process.stdin,
});

inputs.on('line', (stairs: number) => {
  for (let stair: number = 1; stair <= stairs; stair++) {
    const spaces: string = ' '.repeat(stairs - stair);
    const stars: string = '*'.repeat(2 * stair - 1);
    console.log(spaces + stars);
  }
  inputs.close();
});
