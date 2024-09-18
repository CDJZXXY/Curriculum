import TabList from '@mui/lab/TabList';
import { Box, Tab } from '@mui/material';
import { ChangeCategoryPropsType, SelectedCategoryType } from '../type/types';

const CategoryTabs: React.FC<ChangeCategoryPropsType> = ({
  categories,
  onChangeCategory,
}) => {
  const handleChange = (
    _event: React.SyntheticEvent,
    newValue: SelectedCategoryType,
  ) => {
    onChangeCategory(newValue);
  };
  return (
    <Box
      sx={{
        width: '100%',
        borderBottom: 1,
        borderColor: 'divider',
        backgroundColor: 'white',
        position: 'fixed',
        zIndex: 30,
      }}
    >
      <TabList onChange={handleChange}>
        {categories.map((item) => (
          <Tab key={item.id} label={item.label} value={item.value} />
        ))}
      </TabList>
    </Box>
  );
};

export default CategoryTabs;
