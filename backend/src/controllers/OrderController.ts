import { create } from "domain";
import { Request, Response } from "express";
import { RowDataPacket } from "mysql2";
import { executeQuery } from "../config/dbConfig";
import { AllOrder, deleteUserOrder, UserOrder } from "../queries/query";

export const getAllOrder = async (req: Request, res: Response) => {
  try {
    const order = await executeQuery(AllOrder);
    res.status(200).json(order);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
export const getUserOrder = async (req: Request, res: Response) => {
  try {
    const userId = parseInt(req.params.id);
    const order = await executeQuery(UserOrder(userId));
    res.status(200).json(order);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

export const deleteOrder = async (req: Request, res: Response) => {
  try {
    const orderId = parseInt(req.params.id);
    const removeOrder = await executeQuery(deleteUserOrder(orderId));
    res.status(200).json(removeOrder);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};

export const createOrder = async (req: Request, res: Response) => {
  try {
    const { course_id, user_id } = req.body;
    const createOrderQuery = `INSERT INTO Orders (user_id) VALUES (${user_id})`;
    const orderResult = await executeQuery(createOrderQuery);

    const orderId = (orderResult as RowDataPacket).insertId;

    const creatOrderItemQuery = `INSERT INTO OrderItem (user_id,order_id,course_id) VALUES (${user_id},${orderId},${course_id})`;

    const orderItemResult = await executeQuery(creatOrderItemQuery);

    res.status(200).json(orderItemResult);
  } catch (error) {
    const err = error as Error;
    res.status(400).json({ error: err.message });
  }
};
