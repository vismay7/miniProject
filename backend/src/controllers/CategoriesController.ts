import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";

export const getCategories = async (req: Request, res: Response): Promise<void> => {
  try {
    let categories = await executeQuery("SELECT Categories.category_id, Categories.category_name, GROUP_CONCAT (Subcategories.subcategory_name) AS sub_categories FROM Categories INNER JOIN Subcategories ON Categories.category_id = Subcategories.category_id GROUP BY Categories.category_id, Categories.category_name;");

    categories.map((categorie) => {
      if (categorie.sub_categories) {
        let subCategories = categorie.sub_categories;
        categorie.sub_categories = subCategories.split(",");
        return categorie.sub_categories;
      } else {
        return categorie;
      }
    });

    res.status(200).json(categories);
  } catch (error) {
    res.status(500).json({ message: "Category not Found" });
  }
};
