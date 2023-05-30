import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";
import { getAllCategories } from "../queries/query";

export const getCategories = async (req: Request, res: Response): Promise<void> => {
  try {
    let categories = await executeQuery(getAllCategories);

    res.status(200).json(categories);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
