import { Request, Response } from "express";
import { executeQuery } from "../config/dbConfig";
import { deleteCourseQuery, getAllCourse, getCourseDetails, updateCourseQuery } from "../queries/query";
import { RowDataPacket } from "mysql2/promise";
import { CompletionTriggerKind } from "typescript";

// http://localhost/
// Get all courses
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
// Get a course by ID
export const getCourse = async (req: Request, res: Response) => {
  try {
    const courseId = parseInt(req.params.id);
    const course = await executeQuery(getCourseDetails(courseId));
    if (course.length === 0) {
      res.status(404).json({ error: "Course not found" });
    } else {
      res.status(200).json(course[0]);
    }
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

//http://localhost/course
//create course
export const createCourse = async (req: Request, res: Response) => {
  try {
    // Extract updated course details from request body
    const { course_title, course_description, course_price, course_is_free, category_name, subcategory_name, topics } = req.body;

    // Check if the category exists
    const categoryQuery = `SELECT id FROM Category WHERE name = '${category_name}';`;
    const categoryResult = await executeQuery(categoryQuery);

    let categoryId: number;

    if (categoryResult.length === 0) {
      // Category does not exist, so create a new one
      const createCategoryQuery = `INSERT INTO Category (name) VALUES ('${category_name}');`;
      const createCategoryResult = await executeQuery(createCategoryQuery);
      categoryId = (createCategoryResult as RowDataPacket).insertId;
    } else {
      // Category exists, use the existing category ID
      categoryId = categoryResult[0].id;
    }

    // Check if the subcategory exists within the specified category
    const subcategoryQuery = `SELECT id FROM Subcategory WHERE name = '${subcategory_name}' AND category_id = ${categoryId};`;
    const subcategoryResult = await executeQuery(subcategoryQuery);

    let subcategoryId: number;

    if (subcategoryResult.length === 0) {
      // Subcategory does not exist, so create a new one
      const createSubcategoryQuery = `INSERT INTO Subcategory (name, category_id) VALUES ('${subcategory_name}', ${categoryId});`;
      const createSubcategoryResult = await executeQuery(createSubcategoryQuery);
      subcategoryId = (createSubcategoryResult as RowDataPacket).insertId;
    } else {
      // Subcategory exists, use the existing subcategory ID
      subcategoryId = subcategoryResult[0].id;
    }

    // Execute the query with the provided course details and the obtained category and subcategory IDs
    const createCourseQuery = `INSERT INTO Course (title, description, price, is_free, category_id, subcategory_id)
                               VALUES ('${course_title}', '${course_description}', ${course_price}, ${course_is_free}, ${categoryId}, ${subcategoryId});`;
    const createCourseResult = await executeQuery(createCourseQuery);

    const courseId = (createCourseResult as RowDataPacket).insertId;

    // Create the topics and subtopics
    for (const topic of topics) {
      const { topic_title, subtopics } = topic;

      const createTopicQuery = `INSERT INTO Topic (course_id, title) VALUES (${courseId}, '${topic_title}');`;
      const createTopicResult = await executeQuery(createTopicQuery);

      const topicId = (createTopicResult as RowDataPacket).insertId;

      for (const subtopic of subtopics) {
        const { subtopic_title, files } = subtopic;

        const createSubtopicQuery = `INSERT INTO Subtopic (topic_id, title) VALUES (${topicId}, '${subtopic_title}');`;
        const createSubtopicResult = await executeQuery(createSubtopicQuery);

        if (files) {
          const subtopicId = (createSubtopicResult as RowDataPacket).insertId;
          // Create the files for each subtopic
          for (const file of files) {
            const { file_name, file_path } = file;
            const createFileQuery = `INSERT INTO File (subtopic_id, filename, filepath) VALUES (${subtopicId}, '${file_name}', '${file_path}');`;
            await executeQuery(createFileQuery);
          }
        }
      }
    }

    res.status(201).json({ message: "Course created successfully", courseId });
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

// Update a course by ID
export const updateCourse = async (req: Request, res: Response) => {
  try {
    const courseId = parseInt(req.params.id);
    // Extract updated course details from request body
    const { title, description, price, is_free, category_name, subcategory_name } = req.body;

    // Construct the SQL query to update the course

    let query = "UPDATE Course SET";

    if (title) {
      query += ` title = '${title}',`;
    }
    if (description) {
      query += ` description = '${description}',`;
    }
    if (price) {
      query += ` price = '${price}',`;
    }
    if (is_free) {
      query += ` is_free = '${is_free}',`;
    }

    //check category is on req.body
    if (category_name) {
      // Check if the category exists
      const categoryQuery = `SELECT id FROM Category WHERE name = '${category_name}';`;
      const categoryResult = await executeQuery(categoryQuery);

      let categoryId: number;

      if (categoryResult.length === 0) {
        // Category does not exist, so create a new one
        const createCategoryQuery = `INSERT INTO Category (name) VALUES ('${category_name}');`;
        const createCategoryResult = await executeQuery(createCategoryQuery);
        categoryId = (createCategoryResult as RowDataPacket).insertId;
      } else {
        // Category exists, use the existing category ID
        categoryId = categoryResult[0].id;
      }

      //check subcategory on req.body
      if (subcategory_name) {
        // Check if the subcategory exists within the specified category
        const subcategoryQuery = `SELECT id FROM Subcategory WHERE name = '${subcategory_name}' AND category_id = ${categoryId};`;
        const subcategoryResult = await executeQuery(subcategoryQuery);

        let subcategoryId: number;

        if (subcategoryResult.length === 0) {
          // Subcategory does not exist, so create a new one
          const createSubcategoryQuery = `INSERT INTO Subcategory (name, category_id) VALUES ('${subcategory_name}', ${categoryId});`;
          const createSubcategoryResult = await executeQuery(createSubcategoryQuery);
          subcategoryId = (createSubcategoryResult as RowDataPacket).insertId;
        } else {
          // Subcategory exists, use the existing subcategory ID
          subcategoryId = subcategoryResult[0].id;
        }
        if (categoryId) {
          query += ` category_id = (SELECT id FROM Category WHERE name = '${categoryId})',`;
        }
        if (subcategoryId) {
          query += ` subcategory_id = (SELECT id FROM Subcategory WHERE name = '${subcategoryId})',`;
        }
      }
    }

    //Remove the tralling comma from the query
    query = query.slice(0, -1);

    query += ` WHERE id = ${courseId};`;

    // // Execute the query with the provided course details and course ID
    const result = await executeQuery(query);

    // // Check if any rows were affected by the update
    if ((result as RowDataPacket).affectedRows === 0) {
      res.status(404).json({ error: "Course not found" });
    } else {
      res.status(200).json({ message: "Course updated successfully", query });
    }
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

// Delete a course by ID
export const deleteCourse = async (req: Request, res: Response) => {
  try {
    const courseId = parseInt(req.params.id);

    // Construct the SQL query to delete the course
    const query = `
      DELETE FROM Course WHERE id = ${courseId};
    `;

    // Execute the query with the provided course ID
    const result = await executeQuery(query);

    // Check if any rows were affected by the delete operation
    if ((result as RowDataPacket).affectedRows === 0) {
      res.status(404).json({ error: "Course not found" });
    } else {
      res.status(200).json({ message: "Course deleted successfully" });
    }
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
