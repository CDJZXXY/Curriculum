import pluginJs from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';

export default [
  { files: ['**/*.{js,mjs,cjs,ts}'] },
  {
    languageOptions: { globals: { ...globals.browser, ...globals.node } },
    rules: {
      quotes: ['error', 'single', { allowTemplateLiterals: true }],
      indent: ['error', 2],
      'arrow-parens': ['error', 'always'],
    },
  },
  pluginJs.configs.recommended,
  ...tseslint.configs.recommended,
];
