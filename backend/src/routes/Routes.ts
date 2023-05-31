import { Router } from "express";
import CategoriesRouter from "./CategoriesRoutes";
import coursesRouter from "./CoursesRoutes";
import loginRouter from "./LoginRoutes";
import orderRouter from "./OrderRoutes";
import paymentRouter from "./PaymentRoutes";
import usersRoutes from "./UsersRoutes";

const routes = Router();

routes.use("/", coursesRouter);
routes.use("/", loginRouter);
routes.use("/categories", CategoriesRouter);
routes.use("/users", usersRoutes);
routes.use("/payment", paymentRouter);
routes.use("/order", orderRouter);

export default routes;
