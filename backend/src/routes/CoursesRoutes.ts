import { Router } from "express";
import { getCourses } from "../controllers/CoursesController";

const coursesRouter = Router();

coursesRouter.get("/", getCourses);

export default coursesRouter;
