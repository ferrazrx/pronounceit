import { NextFunction, Request, Response, ErrorRequestHandler } from "express";

export const errorHandling = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.error(err);

  let statusCode = err.statusCode || 500;

  if (err instanceof TypeError) {
    statusCode = 400;
  } else if (err.name === "UnauthorizedError") {
    statusCode = 401;
  }

  const errorResponse = {
    error: {
      message: err.message || "Internal Server Error",
      code: statusCode,
      details: "",
    },
  };
  if (err.expose) {
    errorResponse.error.details = err.details;
  }

  res.status(statusCode).json(errorResponse);
};
