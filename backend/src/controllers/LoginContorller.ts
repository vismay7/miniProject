import { Request, Response } from "express";
import bcrypt from "bcrypt";
import { executeQuery } from "../config/dbConfig";
import jwt from "jsonwebtoken";

export const login = async (req: Request, res: Response) => {
  try {
    const { email, password } = req.body;

    const findUser = `SELECT * FROM User WHERE email='${email}'`;
    const [rows] = await executeQuery(findUser);
    const loginCheckPass = await bcrypt.compare(password, rows.password);
    if (!loginCheckPass) {
      throw new Error("password is not valid");
    }
    const token = jwt.sign(rows, process.env.JWT_SECRET!);
    res.status(200).json(token);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

export const signUp = async (req: Request, res: Response) => {
  try {
    let { email, fullname, password } = req.body;
    password = await bcrypt.hash(password, 10);
    const signUpQuery = `INSERT INTO User (email,fullname,password) VALUES ('${email}','${fullname}','${password}')`;
    const signUpResult = await executeQuery(signUpQuery);
    res.status(200).json(signUpResult);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
