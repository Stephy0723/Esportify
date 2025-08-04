const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');    
const connectDB = require('./config/db');
const teamRoutes = require('./routes/teamRoutes');
const mainRoutes = require('./routes/mainRoutes');

dotenv.config();
connectDB();

const app = express();
app.use(express.json());
app.use(cors());

app.use('/api/users', require('./routes/userRouters'));
app.use('/api/teams', teamRoutes);
app.use('/api/main', mainRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT}`);
});