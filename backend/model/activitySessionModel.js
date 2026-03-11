import mongoose from "mongoose";

const activitySchema = new mongoose.Schema({
    activityName: {
        type: String,
        required: true,
        trim: true
    },

    type: {
        type: String,
        enum: ["work", "break"],
        default: "work"
    },

    duration: {
        type: Number,
        required: true,
        min: 1
    },

    points: {
        type: Number,
        default: 0
    },

    dismissed: {
        type: Boolean,
        default: false
    }

}, { _id: false });


const activitySessionSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    },

    duration: {
        type: Number,
        required: true,
        min: 1
    },

    activities: {
        type: [activitySchema],
        default: []
    },

    isCompleted: {
        type: Boolean,
        default: false
    }

}, { timestamps: true });


activitySessionSchema.pre("save", async function () {
    let totalActivityDuration = 0;

    this.activities.forEach(activity => {
        totalActivityDuration += activity.duration;

        if (activity.type === "break" || activity.dismissed) {
            activity.points = 0;
        } else {
            activity.points = activity.duration * 10;
        }
    });

    if (totalActivityDuration > this.duration) {
        throw new Error("Total activity duration cannot exceed session duration");
    }
});

const ActivitySession = mongoose.model("ActivitySession", activitySessionSchema);

export default ActivitySession;