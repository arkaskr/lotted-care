import ActivitySession from "../model/activitySessionModel.js";
import User from "../model/userModel.js";

// @desc    Create a new activity session
// @route   POST /api/activity/create
// @access  Public (should be Private in production)
export const createSession = async (req, res) => {
    try {
        const { userId, duration, activities } = req.body;

        if (!userId || !duration) {
            return res.status(400).json({ message: "Please provide userId and duration" });
        }

        // Check if user exists
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        const newSession = new ActivitySession({
            user: userId,
            duration,
            activities: activities || []
        });

        const savedSession = await newSession.save();

        // Add session to user's activitySessions
        user.activitySessions.push(savedSession._id);
        await user.save();

        res.status(201).json({
            message: "Session created successfully",
            session: savedSession
        });

    } catch (error) {
        console.error("Create session error:", error);
        res.status(500).json({ message: error.message || "Server error during session creation" });
    }
};

// @desc    Get all sessions for a user
// @route   GET /api/activity/list/:userId
// @access  Public
export const getSessions = async (req, res) => {
    try {
        const { userId } = req.params;

        if (!userId) {
            return res.status(400).json({ message: "Please provide userId" });
        }

        const sessions = await ActivitySession.find({ user: userId })
            .sort({ createdAt: -1 });

        res.status(200).json(sessions);

    } catch (error) {
        console.error("Get sessions error:", error);
        res.status(500).json({ message: "Server error during session retrieval" });
    }
};

// @desc    Update session completion status
// @route   PATCH /api/activity/status/:sessionId
// @access  Private
export const updateSessionStatus = async (req, res) => {
    try {
        const { sessionId } = req.params;
        const { isCompleted, activities } = req.body;

        const session = await ActivitySession.findById(sessionId);

        if (!session) {
            return res.status(404).json({ message: "Session not found" });
        }

        if (isCompleted !== undefined) session.isCompleted = isCompleted;
        if (activities !== undefined) session.activities = activities;

        await session.save(); // Triggers the pre-save hook for point calculation

        res.status(200).json({
            message: "Session updated successfully",
            session
        });

    } catch (error) {
        console.error("Update session error:", error);
        res.status(500).json({ message: "Server error during update" });
    }
};

export default { createSession, getSessions, updateSessionStatus };
