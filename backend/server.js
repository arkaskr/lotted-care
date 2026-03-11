import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './config/connectDB.js';
import chatRouter from './router/chatRouter.js';
import activityRouter from './router/activityRouter.js';
import userRouter from './router/userRouter.js';

dotenv.config();
connectDB();

const app = express();
app.use(cors());

const PORT = process.env.PORT || 5000

app.use(express.json());

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.use('/api/chat', chatRouter)
app.use('/api/activity', activityRouter)
app.use('/api/user', userRouter)



app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT} and listening on 0.0.0.0`);
});

