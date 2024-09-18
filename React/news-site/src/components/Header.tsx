import { AppBar, Box, Toolbar, Typography } from '@mui/material';

export default function Header() {
  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="fixed">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            NewsSite
          </Typography>
        </Toolbar>
      </AppBar>
    </Box>
  );
}
