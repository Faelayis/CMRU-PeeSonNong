"use server";
import { fetchApi } from "@/app/api/featch";

export const fetchActionApi = async <T>(
	path: string,
	options: RequestInit & {} = {
		method: "GET",
	},
	populate?: Record<string, unknown>,
	filters?: Record<string, unknown>,
) => {
	return fetchApi<T>(path, options, populate, filters);
};
