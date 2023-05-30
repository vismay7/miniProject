import { Router } from "express";
import { getAllUsers } from "../controllers/UsersControlller";

const usersRoutes = Router();

usersRoutes.get("/", getAllUsers);

export default usersRoutes;
