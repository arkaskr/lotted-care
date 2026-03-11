import OpenAI from "openai";
import dotenv from 'dotenv';
dotenv.config();

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export const analyzeSymptoms = async (req, res) => {
  try {
    const { symptoms } = req.body;
    console.log(`Analyzing symptoms: ${symptoms}`);

    const completion = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        {
          role: "system",
          content: `You are Lotted AI, a professional and empathetic medical assistant.
          
          Instructions:
          1. Answer the user's input naturally. If they greet you, greet them back formally.
          2. If the user asks a medical question or provides symptoms, provide a helpful conversational reply AND structured analysis data.
          3. If the input is not related to health, still respond politely as a medical assistant would.
          
          Return JSON format:
          {
            "reply": "Your conversational response to the user",
            "analysis": { // ONLY include this if symptoms or medical questions are provided. Otherwise, set to null.
              "suggestion": "Medical conditions or care advice",
              "specialist": "Target specialist",
              "urgency": "low | medium | high"
            }
          }`
        },
        {
          role: "user",
          content: symptoms
        }
      ],
      response_format: { type: "json_object" }
    });

    const response = JSON.parse(completion.choices[0].message.content);
    console.log("AI reply:", response.reply);

    res.json(response);

  } catch (error) {
    console.error("Error analyzing symptoms:", error.message);
    res.status(500).json({ error: error.message });
  }
};

export default { analyzeSymptoms };