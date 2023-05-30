import { Router } from "express";
import { getCategories } from "../controllers/CategoriesController";

const CategoriesRouter = Router();

CategoriesRouter.get("/", getCategories);

export default CategoriesRouter;
