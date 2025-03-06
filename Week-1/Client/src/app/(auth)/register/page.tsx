"use client";
import { useState } from "react";

import { fetchActionApi } from "@/app/api/action";

export default function Register() {
	const [username, setUsername] = useState("");
	const [email, setEmail] = useState("");
	const [password, setPassword] = useState("");
	const [confirmPassword, setConfirmPassword] = useState("");

	const register = async (event: React.FormEvent) => {
		event.preventDefault();

		if (password !== confirmPassword) {
			alert("Passwords do not match");
			return;
		}

		const body = {
			username,
			email,
			password,
		};

		try {
			const res = await fetchActionApi("/api/auth/local/register", {
				method: "POST",
				body: JSON.stringify(body),
			});

			if (res.status !== 200) {
				console.error(res);
				alert("Error during registration");
				return;
			}

			console.log("Registration successful", res);
		} catch (error) {
			console.error("An error occurred", error);
			alert("An error occurred during registration");
		}
	};

	return (
		<div className="flex items-center justify-center" style={{ backgroundColor: "" }}>
			<div className="bg-white bg-opacity-75 p-8 rounded-lg shadow-lg w-full max-w-sm">
				<h1 className="text-2xl font-semibold text-center text-gray-800 mb-6">Register</h1>
				<form onSubmit={(e) => register(e)}>
					<div className="mb-4">
						<label htmlFor="username" className="block text-sm font-medium text-gray-700 mb-2">
							Username
						</label>
						<input
							type="text"
							id="username"
							name="username"
							value={username}
							onChange={(e) => setUsername(e.target.value)}
							className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
							required
						/>
					</div>
					<div className="mb-4">
						<label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-2">
							Gmail
						</label>
						<input
							type="email"
							id="email"
							name="email"
							value={email}
							onChange={(e) => setEmail(e.target.value)}
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
					<div className="mb-6">
						<label htmlFor="confirmPassword" className="block text-sm font-medium text-gray-700 mb-2">
							Confirm password
						</label>
						<input
							type="password"
							id="confirmPassword"
							name="confirmPassword"
							value={confirmPassword}
							onChange={(e) => setConfirmPassword(e.target.value)}
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
			</div>
		</div>
	);
}
