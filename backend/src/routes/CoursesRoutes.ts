import { Router } from "express";
import { createCourse, getCourse, getCourses } from "../controllers/CoursesController";

const coursesRouter = Router();

// GET /courses
coursesRouter.get("/", getCourses);

// GET /courses/:id
coursesRouter.get("/course/:id", getCourse);

// POST /courses
coursesRouter.post("/course/", createCourse);

// PUT /courses/:id
// coursesRouter.put("/course/:id", updateCourse);

// DELETE /courses/:id
// coursesRouter.delete("/course/:id", deleteCourse);

export default coursesRouter;
