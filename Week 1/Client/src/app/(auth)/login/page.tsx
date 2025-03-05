"use client";

import { fetchActionApi } from "@/app/api/action";
import { useState } from "react";

export default function Page() {
   const [identifier, setIdentifier] = useState("test");
   const [password, setPassword] = useState("111111");

	const login = async (event: React.FormEvent) => {
		event.preventDefault();

		const res = await fetchActionApi("/api/auth/local", {
			body: JSON.stringify({
				identifier: identifier,
				password: password,
			}),
			method: "POST",
		});

		console.log(res);
		if (res) {
			if (res.status === 200) {
				window.location.href = "/";
			} else {
				alert("Login failed");
			}
		}
	};

	return (
		<form onSubmit={login}>
			<div>
				<label htmlFor="username">Username:</label>
				<input type="text" id="username" value={identifier} onChange={(e) => setIdentifier(e.target.value)} />
			</div>
			<div>
				<label htmlFor="password">Password:</label>
				<input type="password" id="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
			</div>
			<button type="submit">Login</button>
		</form>
	);
}
