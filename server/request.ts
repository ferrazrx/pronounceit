import { z } from "zod";

export const requestSchema = z.object({
  text1: z.string(),
  text2: z.string(),
  language: z.string(),
});
