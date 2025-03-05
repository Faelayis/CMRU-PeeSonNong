import Link from "next/link";

import NavigationLink from "@/app/components/navigation";

const links = [
	{ href: "/", label: "Home" },
	{ href: "/our-team", label: "Our Team" },
	{ href: "/login", label: "Login" },
];

export default function Header() {
	return (
		<header className="bg-white/50 text-black">
			<nav className="container mx-auto flex justify-between items-center py-4">
				<Link href="/">Our Cool Project</Link>

				<ul className="flex gap-4 c">
					{links.map((link) => (
						<NavigationLink key={link.href} href={link.href}>
							{link.label}
						</NavigationLink>
					))}
				</ul>
			</nav>
		</header>
	);
}
