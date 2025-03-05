import { RichTextBlock } from "@/app/components/blocks/rich-text-block";
import { SpoilerBlock } from "@/app/components/blocks/spoiler-block";
import { TestimonialBlock } from "@/app/components/blocks/testimonial-block";

type TeamPageBlock = SpoilerBlock | TestimonialBlock | RichTextBlock;

const blocks: Record<string, React.ComponentType<{ block: TeamPageBlock }>> = {
	"blocks.spoiler": ({ block }: { block: TeamPageBlock }) => <SpoilerBlock key="spoiler" block={block as SpoilerBlock} />,
	"blocks.testimonial": ({ block }: { block: TeamPageBlock }) => <TestimonialBlock key="testimonial" block={block as TestimonialBlock} />,
	"blocks.rich-text": ({ block }: { block: TeamPageBlock }) => <RichTextBlock key="rich-text" block={block as RichTextBlock} />,
};

function BlockRenderer({ block }: { block: TeamPageBlock }) {
	const BlockComponent = blocks[block.__component];
	return BlockComponent ? <BlockComponent block={block} /> : null;
}

export { BlockRenderer };
export type { TeamPageBlock };
