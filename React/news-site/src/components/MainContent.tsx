import { TabContext, TabPanel } from '@mui/lab';
import { Box } from '@mui/material';
import { useEffect, useState } from 'react';
import '../assets/css/MainContent.css';
import CategoryData from '../data/Catagories.json';
import {
  CategoriesDataType,
  NewsDataType,
  SelectedCategoryType,
} from '../type/types';
import CategoryTabs from './CategoryTabs';
import Loading from './Loading';
import NewsCard from './NewsCard';

export default function MainContent() {
  const categories: CategoriesDataType[] = CategoryData;
  const [category, setCategory] = useState<SelectedCategoryType>('top');
  const [newsList, setNewsList] = useState<NewsDataType[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const changeCategory = (newValue: SelectedCategoryType) => {
    setCategory(newValue);
  };

  useEffect(() => {
    async function getNewsIds() {
      try {
        const response: Response = await fetch(
          `https://hacker-news.firebaseio.com/v0/${category}stories.json`,
        );
        const ids: number[] = await response.json();
        return ids.slice(0, 10);
      } catch (error) {
        console.error(error);
      }
    }

    async function getNewsData(id: number) {
      try {
        const url: string = `https://hacker-news.firebaseio.com/v0/item/${id}.json`;
        const reponse: Response = await fetch(url);
        return await reponse.json();
      } catch (error) {
        console.error(error);
      }
    }

    async function init() {
      setIsLoading(true);
      const ids = await getNewsIds();
      if (ids) {
        const newsDataList: NewsDataType[] = await Promise.all(
          ids.map((id) => getNewsData(id)),
        );
        if (newsDataList) {
          setNewsList(newsDataList);
          setIsLoading(false);
        }
      }
    }
    init();
  }, [category]);
  return (
    <Box sx={{ width: '100%', typography: 'body1' }}>
      <TabContext value={category}>
        <CategoryTabs
          categories={categories}
          onChangeCategory={changeCategory}
        />
        <TabPanel
          value={category}
          sx={{ maxHeight: '100vh', overflowY: 'auto' }}
        >
          <Box
            sx={{
              display: 'flex',
              gap: 5,
              flexDirection: 'column',
              margin: '120px 0 50px',
            }}
          >
            {isLoading ? (
              <Loading />
            ) : (
              newsList.map((item) => <NewsCard key={item.id} newsData={item} />)
            )}
          </Box>
        </TabPanel>
      </TabContext>
    </Box>
  );
}
