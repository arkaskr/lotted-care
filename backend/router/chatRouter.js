import express from 'express';
import { analyzeSymptoms } from '../controller/chatController.js';

const chatRouter = express.Router();

chatRouter.post('/analyze-symptoms', analyzeSymptoms )

export default chatRouter;