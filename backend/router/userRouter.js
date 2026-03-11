import express from 'express';
import { register, login, getProfile } from '../controller/userController.js';
import { protect } from '../middleware/authMiddleware.js';

const userRouter = express.Router();

userRouter.post('/register', register)
userRouter.post('/login', login)
userRouter.get('/profile', protect, getProfile)

export default userRouter;