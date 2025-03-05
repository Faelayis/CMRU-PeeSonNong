"use server";
import { cookies } from "next/headers";
import { fetchApi } from "@/app/api/featch";

export const setAccessToken = async (token: string) => {
  const cookie = await cookies();
  cookie.set("access_token", `${token}`, {
    maxAge: 60 * 60 * 24 * 30,
  });
};

export const fetchActionApi = async <T>(
  path: string,
  options: RequestInit & {} = {
    method: "GET",
  },
  populate?: any,
  filters?: any,
) => {

  return fetchApi<T>(path, options, populate, filters);
};