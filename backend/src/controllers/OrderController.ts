import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";
import { AllOrder } from "../queries/query";

export const getAllOrder = async (req: Request, res: Response) => {
  try {
    const order = await executeQuery(AllOrder);
    res.status(200).json(order);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
export const getUserOrder = async (req: Request, res: Response) => {
  try {
    const userId = req.params.id;
    const order = await executeQuery(AllOrder);
    res.status(200).json(order);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
