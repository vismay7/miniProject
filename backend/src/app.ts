import express, { Express } from "express";
import routes from "./routes/Routes";

const app: Express = express();

app.use("/", routes);

app.listen(3000, () => {
  console.log("Server is listening on port 3000");
});
