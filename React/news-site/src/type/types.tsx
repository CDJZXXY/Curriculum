export type SelectedCategoryType = 'top' | 'new' | 'best';
export type CategoriesDataType = {
  id: number;
  label: string;
  value: string;
};
export type NewsDataType = {
  by: string;
  descendants: number;
  id: number;
  kids?: number[];
  score: number;
  time: number;
  title: string;
  type: string;
  url?: string;
};
export type NewsPropsType = {
  newsData: NewsDataType;
};
export type ChangeCategoryPropsType = {
  categories: CategoriesDataType[];
  onChangeCategory: (newValue: SelectedCategoryType) => void;
};
