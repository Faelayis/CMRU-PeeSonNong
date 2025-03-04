import { cookies } from "next/headers";
import qs from 'qs';

interface FetchResponse<T> {
    data: T | null;
    status?: string | number;
    error?: string;
}

export const fetchApi = async <T>(
    path: string,
    options: RequestInit = { method: "GET" },
    params?: {
        populate?: any,
        filters?: any,
    },
): Promise<FetchResponse<T>> => {
    const cookie = await cookies();
    const accessToken = cookie.get("access_token")?.value || "";
    const { populate, filters } = params || {};
    const headers: HeadersInit = {
        "Content-type": "application/json",
        ...(accessToken && { "Authorization": `Bearer ${accessToken}` })
    };

    let url: string;

    if (populate) {
        const queryParams: any = { populate, ...(filters && { filters }) };
        const newUrl = new URL(path, process.env.API_URL);
        newUrl.search = qs.stringify(queryParams);
        url = newUrl.toString();
    } else {
        url = `${process.env.API_URL}${path}`;
    }

    try {
        const response = await fetch(url, { ...options, headers });
        const data = await response.json();

        return { data, status: response.status };
    } catch (error) {
        return { data: null, status: 500, error: error instanceof Error ? error.message : "Unknown error" };
    }
};
