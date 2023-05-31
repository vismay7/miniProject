import { Router } from "express";
import { createOrder, deleteOrder, getAllOrder, getUserOrder } from "../controllers/OrderController";

const orderRouter = Router();

// GET /order
orderRouter.get("/", getAllOrder);

// GET /order/:id
orderRouter.get("/:id", getUserOrder);

// POST /order
orderRouter.post("/", createOrder);

// DELETE /order/:id
orderRouter.delete("/:id", deleteOrder);

export default orderRouter;
