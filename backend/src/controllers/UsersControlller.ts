import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";
import { User, Users } from "../queries/query";

// http://localhost/users
export const getAllUsers = async (req: Request, res: Response) => {
  try {
    const users = await executeQuery(Users);
    res.status(200).json(users);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

// http://localhost/users/1
export const getUser = async (req: Request, res: Response) => {
  try {
    const userId = parseInt(req.params.id);
    const users = await executeQuery(User(userId));
    res.status(200).json(users);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
