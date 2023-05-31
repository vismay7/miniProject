import { Router } from "express";
import { login, signUp } from "../controllers/LoginContorller";

const loginRouter = Router();

// GET /order
loginRouter.post("/login", login);

// POST /order
loginRouter.post("/sign-up", signUp);

export default loginRouter;
