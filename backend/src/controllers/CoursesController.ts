import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";

export const getCourses = async (req: Request, res: Response) => {
  try {
    const courses = await executeQuery("SELECT * FROM `Courses`");
    res.status(200).json(courses);
  } catch (error) {
    res.status(500).json({ message: "Courses not Fetch" });
  }
};
