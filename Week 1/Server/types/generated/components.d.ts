import type { Schema, Struct } from "@strapi/strapi";

export interface BlocksRichText extends Struct.ComponentSchema {
	collectionName: "components_blocks_rich_texts";
	info: {
		description: "";
		displayName: "richText";
	};
	attributes: {
		content: Schema.Attribute.Blocks;
	};
}

export interface BlocksSpoiler extends Struct.ComponentSchema {
	collectionName: "components_blocks_spoilers";
	info: {
		displayName: "spoiler";
	};
	attributes: {
		content: Schema.Attribute.Text;
		title: Schema.Attribute.String;
	};
}

export interface BlocksTestimonial extends Struct.ComponentSchema {
	collectionName: "components_blocks_testimonials";
	info: {
		displayName: "Testimonial";
	};
	attributes: {
		authorName: Schema.Attribute.String;
		photo: Schema.Attribute.Media<"images" | "files" | "videos" | "audios">;
		quote: Schema.Attribute.Text;
	};
}

declare module "@strapi/strapi" {
	export module Public {
		export interface ComponentSchemas {
			"blocks.rich-text": BlocksRichText;
			"blocks.spoiler": BlocksSpoiler;
			"blocks.testimonial": BlocksTestimonial;
		}
	}
}
