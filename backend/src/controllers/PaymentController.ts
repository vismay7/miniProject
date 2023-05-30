import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";
import { getAllPaymentQuery, getUserPaymentHistroy } from "../queries/query";

export const getPaymentForUser = async (req: Request, res: Response) => {
  try {
    const userId: number = parseInt(req.params.id);
    const userPayment = await executeQuery(getUserPaymentHistroy(userId));
    res.status(200).json(userPayment);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

export const getAllPayment = async (req: Request, res: Response) => {
  try {
    const userPayment = await executeQuery(getAllPaymentQuery);
    res.status(200).json(userPayment);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
