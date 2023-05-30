import { Router } from "express";
import CategoriesRouter from "./CategoriesRoutes";
import coursesRouter from "./CoursesRoutes";
import usersRoutes from "./UsersRoutes";

const routes = Router();

routes.use("/categories", CategoriesRouter);
routes.use("/users", usersRoutes);
routes.use("/", coursesRouter);

export default routes;
