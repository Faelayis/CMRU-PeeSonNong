"use client";

import { type BlocksContent, BlocksRenderer } from "@strapi/blocks-react-renderer";
import Image from "next/image";

export interface RichTextBlock {
	__component: "blocks.rich-text";
	id: number;
	content: BlocksContent;
}

export function RichTextBlock({ block }: { block: RichTextBlock }) {
	return (
		<div className="richtext">
			<BlocksRenderer
				content={block.content}
				blocks={{
					image: ({ image }) => {
						if (!image) return null;
						return (
							<div className="my-4 flex justify-center">
								<Image
									src={image.url}
									width={image.width || 800}
									height={image.height || 600}
									alt={image.alternativeText || ""}
									className="rounded-lg shadow-md h-[300px] w-full object-cover"
								/>
							</div>
						);
					},
				}}
			/>
		</div>
	);
}
