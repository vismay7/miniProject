import { Router } from "express";
import { getAllUsers, getUser } from "../controllers/UsersControlller";

const usersRoutes = Router();

usersRoutes.get("/", getAllUsers);
usersRoutes.get("/:id", getUser);

export default usersRoutes;
