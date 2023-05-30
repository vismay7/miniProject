import { Router } from "express";
import CategoriesRouter from "./CategoriesRoutes";
import coursesRouter from "./CoursesRoutes";
import paymentRouter from "./PaymentRoutes";
import usersRoutes from "./UsersRoutes";

const routes = Router();

routes.use("/", coursesRouter);
routes.use("/categories", CategoriesRouter);
routes.use("/users", usersRoutes);
routes.use("/payment", paymentRouter);

export default routes;
