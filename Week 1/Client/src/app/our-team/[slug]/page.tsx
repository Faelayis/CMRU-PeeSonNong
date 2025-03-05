import qs from "qs";

import { fetchApi } from "@/app/api/featch";
import { BlockRenderer, TeamPageBlock } from "@/app/components/blocks";

async function getTeamMember(slug: string) {
	const res = (await fetchApi(
		"/api/team-members",
		{},
		{
			photo: {
				fields: ["alternativeText", "name", "url"],
			},
			blocks: {
				on: {
					"blocks.testimonial": {
						populate: {
							photo: {
								fields: ["alternativeText", "name", "url"],
							},
						},
					},
					"blocks.spoiler": {
						populate: true,
					},
					"blocks.rich-text": {
						populate: true,
					},
				},
			},
		},
		{
			slug: {
				$eq: slug,
			},
		},
	)) as any;
	if (res) {
		if (res.status === 200) {
			return res.data?.data[0];
		}
	}
	return res.data?.data[0];
	//   const baseUrl = process.env.API_URL ?? "http://localhost:1337";
	//   const path = "/api/team-members";

	//   const url = new URL(path, baseUrl);

	//   url.search = qs.stringify({
	//     populate: {
	//       photo: {
	//         fields: ["alternativeText", "name", "url"],
	//       },
	//       blocks: {
	//         on: {
	//           "blocks.testimonial": {
	//             populate: {
	//               photo: {
	//                 fields: ["alternativeText", "name", "url"],
	//               },
	//             },
	//           },
	//           "blocks.spoiler": {
	//             populate: true,
	//           },
	//           "blocks.rich-text": {
	//             populate: true,
	//           },
	//         },
	//       },
	//     },
	//     filters: {
	//       slug: {
	//         $eq: slug, // This is the slug for our team member
	//       },
	//     },
	//   });

	//   const res = await fetch(url);

	//   if (!res.ok) throw new Error("Failed to fetch team members");

	//   const data = await res.json();
	//   console.log(data);
	//   const teamMember = data?.data[0];
	//   console.dir(teamMember, { depth: null });
	//   return teamMember;
}

interface UserProfile {
	id: number;
	documentId: string;
	name: string;
	description: string;
	slug: string;
	createdAt: string;
	updatedAt: string;
	publishedAt: string;
	locale: string | null;
	photo: {
		id: number;
		alternativeText: string;
		name: string;
		url: string;
	};
	blocks: TeamPageBlock[];
}

export default async function TeamMemberDetail({ params }: { params: Promise<{ slug: string }> }) {
	const { slug } = await params;

	if (!slug) return <p>No member found</p>;

	const teamMember = (await getTeamMember(slug)) as UserProfile;

	return (
		<div>
			{teamMember.blocks.map((block: TeamPageBlock) => (
				<BlockRenderer key={block.id} block={block} />
			))}
		</div>
	);
}
