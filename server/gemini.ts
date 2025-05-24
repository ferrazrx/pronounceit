import { GoogleGenAI } from "@google/genai";
import { env } from "./env";

const ai = new GoogleGenAI({ apiKey: env.GEMINI_API_KEY });

export const compareText = async (
  text1: string,
  text2: string,
  language: string
) => {
  listAvailableModels();
  const response = await ai.models.generateContentStream({
    model: "gemini-1.5-flash-001",
    contents: `I have two text in ${language}. These are the texts:\n\n${text1}\n\n${text2}\n\n
    
    Can you give me:
    1. In the first line, the difference in pronunciation between the two.
    2. Tips on how to pronounce the first text.
    3. Give a maximum of two sentences.
    `,
  });
  return response;
};

async function listAvailableModels() {
  const modelsList = await ai.models.list();
  console.log(modelsList);
}
