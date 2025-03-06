"use client";

import { useEffect, useState } from "react";

import { delAccessToken, getAccessToken } from "@/app/api/access-token";
import { fetchActionApi } from "@/app/api/action";

export default function Page() {
	const [identifier, setIdentifier] = useState("Faelayis");
	const [password, setPassword] = useState("testtest");
	const [hasToken, setHasToken] = useState(false);

	useEffect(() => {
		async function fetchPosts() {
			const res = await getAccessToken();
			if (res) {
				setHasToken(true);
			}
		}
		fetchPosts();
	}, []);

	const login = async (event: React.FormEvent) => {
		event.preventDefault();

		const res = await fetchActionApi("/api/auth/local", {
			body: JSON.stringify({
				identifier: identifier,
				password: password,
			}),
			method: "POST",
		});

		if (res) {
			if (res.status === 200) {
				setHasToken(true);
			} else {
				alert("Login failed");
			}
		}
	};

	const handleLogout = async () => {
		await delAccessToken();

		setHasToken(false);
	};

	return (
		<>
			<h1 className="text-2xl font-semibold text-center text-gray-800 mb-6">Login</h1>
			<div className="flex items-center justify-center" style={{ backgroundColor: "" }}>
				<div className="bg-white bg-opacity-75 p-8 rounded-lg shadow-lg w-full max-w-sm">
					{hasToken ? (
						<button
							onClick={handleLogout}
							className="w-full py-2 px-4 mt-4 bg-red-600 text-white font-semibold rounded-md hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500">
							Logout
						</button>
					) : (
						<>
							<form onSubmit={(e) => login(e)}>
								<div className="mb-4">
									<label htmlFor="username" className="block text-sm font-medium text-gray-700 mb-2">
										Username
									</label>
									<input
										type="text"
										id="username"
										name="username"
										value={identifier}
										onChange={(e) => setIdentifier(e.target.value)}
										className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
										required
									/>
								</div>
								<div className="mb-4">
									<label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-2">
										Password
									</label>
									<input
										type="password"
										id="password"
										name="password"
										value={password}
										onChange={(e) => setPassword(e.target.value)}
										className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
										required
									/>
								</div>
								<button
									type="submit"
									className="w-full py-2 px-4 bg-blue-600 text-white font-semibold rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
									Submit
								</button>
							</form>
						</>
					)}
				</div>
			</div>
		</>
	);
}
