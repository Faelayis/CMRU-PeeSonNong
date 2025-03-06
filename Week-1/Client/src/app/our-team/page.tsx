import Image from "next/image";
import Link from "next/link";

import { fetchApi } from "@/app/api/featch";

interface TeamMemberProps {
	id: number;
	documentId: string;
	name: string;
	description: string;
	slug: string;
	createdAt: string;
	updatedAt: string;
	publishedAt: string;
	locale: string;
	photo: {
		id: number;
		documentId: string;
		alternativeText: string;
		name: string;
		url: string;
	};
}
function TeamMemberCard({ name, description, photo, slug }: Readonly<TeamMemberProps>) {
	const imageUrl = photo ? `${process.env.API_URL ?? "http://localhost:1337"}${photo.url}` : null;

	return (
		<Link href={`/our-team/${slug}`} className="bg-white rounded-lg shadow-md overflow-hidden">
			{imageUrl ? (
				<Image src={imageUrl} alt={photo.alternativeText} width={500} height={500} />
			) : (
				<div className="w-full h-64 bg-gray-200 flex items-center justify-center" />
			)}
			<div className="p-6">
				<h3 className="text-xl font-semibold mb-2">{name}</h3>
				<p className="text-gray-600">{description}</p>
			</div>
		</Link>
	);
}

// async function getTeamMembers() {
//   const populate = {
//     photo: {
//       fields: ["alternativeText", "name", "url"],
//     },
//   };
//   const res = await fetchApi(`/api/team-members`, populate, {method: "GET"});
//   console.log(res);

//   return res;
// }

const getTeamMembers = async () => {
	const res = await fetchApi(
		"/api/team-members",
		{},
		{
			photo: {
				fields: ["alternativeText", "name", "url"],
			},
		},
	);
	if (res) {
		if (res.status === 200) {
			return res.data;
		}
	}
	return res.data;
};

export default async function OurTeam() {
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	const teamMembers: any = await getTeamMembers();

	return (
		<div>
			<h1 className="text-3xl font-bold mb-8">Our Team</h1>
			<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
				{teamMembers.data.map((member: TeamMemberProps) => (
					<TeamMemberCard key={member.documentId} {...member} />
				))}
			</div>
		</div>
	);
}
