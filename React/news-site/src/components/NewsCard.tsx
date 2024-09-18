import {
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  Typography,
} from '@mui/material';
import { NewsPropsType } from '../type/types';

const NewsCard: React.FC<NewsPropsType> = ({ newsData }) => {
  function formattedDate(date: number) {
    return new Date(date * 1000).toLocaleString();
  }
  return (
    <Box sx={{ minWidth: 275 }}>
      <Card sx={{ minWidth: 275 }}>
        <CardContent>
          <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
            {formattedDate(newsData.time)}
          </Typography>
          <Typography variant="h5" component="div">
            {newsData.title}
          </Typography>
          <Typography sx={{ mb: 1.5 }} color="text.secondary">
            by: {newsData.by}
          </Typography>
          <Typography color="text.secondary">
            score: {newsData.score} points
          </Typography>
        </CardContent>
        <CardActions>
          {newsData.url && (
            <Button href={newsData.url} target="_blank" size="small">
              Learn More
            </Button>
          )}
        </CardActions>
      </Card>
    </Box>
  );
};
export default NewsCard;
