import { z } from "zod";
import dotenv from "dotenv";

dotenv.config();

const envSchema = z.object({
  GEMINI_API_KEY: z.string(),
});

export const env = envSchema.parse(process.env);
