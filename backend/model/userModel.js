import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    name: {
        type: String,
    },
    email: {
        type: String,
    },
    password: {
        type: String,
    },
    role: {
        type: String,
        enum: ['user', 'admin'],
        default: 'user'
    },
    age :{
        type: Number,
    },
    activitySessions: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "ActivitySession"
    }],
    

}, {
    timestamps: true
})

const User = mongoose.model('User', userSchema);

export default User;