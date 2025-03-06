import { fetchApi } from "./featch";

export async function getUser() {
	const res = await fetchApi("/api/users/me");
	if (res && res.status === 200) {
		return res.data;
	}

	return null;
}
