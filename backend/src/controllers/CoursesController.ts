import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";
import { getAllCourse, getCourseDetails } from "../queries/query";

// http://localhost/
export const getCourses = async (req: Request, res: Response) => {
  try {
    const courses = await executeQuery(getAllCourse());
    res.status(200).json(courses);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

// http://localhost/course/1
export const getCourse = async (req: Request, res: Response) => {
  try {
    const courseId = parseInt(req.params.id);
    const course = await executeQuery(getCourseDetails(courseId));
    res.status(200).json(course);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
