import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";

export const getAllUsers = async (req: Request, res: Response) => {
  try {
    const users = await executeQuery("SELECT * FROM `Users`");
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: "All Users Not Found" });
  }
};
