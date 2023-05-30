import mysql, { Connection, RowDataPacket } from "mysql2/promise";

export const getConnection = async (): Promise<Connection> => {
  const dbConnectionString = {
    host: "localhost",
    user: "root",
    password: "asd",
    database: "coursera",
  };
  const con: Connection = await mysql.createConnection(dbConnectionString);
  return con;
};

export const executeQuery = async (query: string): Promise<RowDataPacket[]> => {
  const connection = await getConnection();
  const [rows] = await connection.execute(query);
  await connection.end(); // Optional: Close the connection after executing the query
  return rows as RowDataPacket[];
};
