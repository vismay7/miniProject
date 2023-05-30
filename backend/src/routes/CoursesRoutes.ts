import { Router } from "express";
import { getCourse, getCourses } from "../controllers/CoursesController";

const coursesRouter = Router();

coursesRouter.get("/", getCourses);
coursesRouter.get("/course/:id", getCourse);

export default coursesRouter;
