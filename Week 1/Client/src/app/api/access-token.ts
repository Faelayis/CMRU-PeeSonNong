"use server";
import { cookies } from "next/headers";

export async function getAccessToken() {
	const cookie = await cookies();

	return cookie.get("access_token");
}

export async function setAccessToken(token: string) {
	const cookie = await cookies();

	cookie.set("access_token", `${token}`, {
		maxAge: 60 * 60 * 24 * 30,
	});
}

export async function delAccessToken() {
	const cookie = await cookies();

	cookie.set("access_token", "", {
		maxAge: -1,
	});
}
