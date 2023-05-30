import { Router } from "express";
import { getAllOrder, getUserOrder } from "../controllers/OrderController";

const orderRouter = Router();

// locahost/payment/:userid (database primary key)
orderRouter.get("/", getAllOrder);
orderRouter.get("/:id", getUserOrder);

export default orderRouter;
