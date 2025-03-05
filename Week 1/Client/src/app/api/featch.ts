import { cookies } from "next/headers";
import qs from "qs";

interface FetchResponse<T> {
	data: T | null;
	status?: number;
	error?: unknown;
}

export const fetchApi = async <T>(
	path: string,
	options: RequestInit = {
		method: "GET",
	},
	populate?: Record<string, unknown>,
	filters?: Record<string, unknown>,
): Promise<FetchResponse<T>> => {
	const coockie = await cookies();
	const accessToken = coockie.get("access_token")?.value || "";

	const headers: HeadersInit = {
		"Content-Type": "application/json",
		...(accessToken && { Authorization: `Bearer ${accessToken}` }),
	};

	let url: string;
	if (populate || filters) {
		const queryParams: Record<string, unknown> = {};

		if (populate) queryParams.populate = populate;
		if (filters) queryParams.filters = filters;

		const newUrl = new URL(path, process.env.API_URL);
		newUrl.search = qs.stringify(queryParams);
		url = newUrl.toString();
	} else {
		url = `${process.env.API_URL}${path}`;
	}

	try {
		const response = await fetch(url, { ...options, headers });
		const result = await response.json();

		if (!response.ok) {
			return { data: null, error: result };
		}

		return {
			data: result,
			status: response.status,
		};
	} catch (error: unknown) {
		return {
			data: null,
			status: 500,
			error: error instanceof Error ? error.message : "Unknown error",
		};
	}
};
