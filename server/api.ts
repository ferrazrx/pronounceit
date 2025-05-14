import { Request, Router, Response } from "express";
import { requestSchema } from "./request";
import { compareText } from "./gemini";

export const apiRoutes = () => {
  const routes = Router();

  routes.post("/api/compare", async (req: Request, res: Response) => {
    const { data, error } = requestSchema.safeParse(req.body);

    if (error) {
      console.error(error);
      res
        .status(400)
        .send("You must provide two texts and the desired language.");
      return;
    }

    const chuncks = await compareText(data.text1, data.text2, data.language);

    res.setHeader("Content-Type", "text/plain");
    res.setHeader("Transfer-Encoding", "chunked");

    for await (const chunk of chuncks) {
      console.log(chunk.text);
      res.write(chunk.text);
    }
    res.end();
  });

  return routes;
};
