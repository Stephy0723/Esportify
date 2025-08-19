const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');    
const connectDB = require('./config/db');
const mobaRoutes = require('./routes/mobaTeamRoutes');
const mainRoutes = require('./routes/mainRouters');

dotenv.config();
connectDB();

const app = express();
app.use(express.json());
app.use(cors());

app.use('/api/users', require('./routes/userRouters'));

app.use('/api/mobaTeams', mobaRoutes);
app.use('/api/events', mainRoutes);
app.use('/api/mobaTeams', require('./routes/mobaTeamRoutes'));


const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0',() => {
    console.log(`Server is running on port ${PORT}`);
});