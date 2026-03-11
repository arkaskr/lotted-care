import { createSession, getSessions, updateSessionStatus } from '../controller/sessionActivityController.js';
import { protect } from '../middleware/authMiddleware.js';
import express from 'express';

const activityRouter = express.Router();

// All activity routes are protected
activityRouter.use(protect);

activityRouter.get('/list/:userId', getSessions)
activityRouter.post('/create', createSession)
activityRouter.patch('/status/:sessionId', updateSessionStatus)

export default activityRouter;