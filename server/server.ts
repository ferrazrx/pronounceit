import express, { Request, Response } from "express";
import bodyParser from "body-parser";
import { errorHandling } from "./errorHandling";
import { apiRoutes } from "./api";

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.text());

app.get("/health-check", (req: Request, res: Response) => {
  res.status(200).send();
});

app.use(apiRoutes());
app.use(errorHandling);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
