import { Router } from "express";
import { getAllPayment, getPaymentForUser } from "../controllers/PaymentController";

const paymentRouter = Router();

// locahost/payment/:userid (database primary key)
paymentRouter.get("/", getAllPayment);
paymentRouter.get("/:id", getPaymentForUser);

export default paymentRouter;
