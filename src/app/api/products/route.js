import verifyApiRequest from "@/auth/verifyApiRequest";
import { ObjectId } from "mongodb";
import { ProductRepository } from "@/repositories/ProductRepository";
import { NextResponse } from "next/server";

export async function POST(request) {
	console.log("POST request received");
	const authResult = await verifyApiRequest(request);
	if (!authResult.isValid) {
		return NextResponse.json({ message: "Unauthorized" }, { status: 401 });
	}

    const decoded = authResult.data;

	try {
		const userId = new ObjectId(decoded.userId);
        const productRepository = new ProductRepository();
		const createdProduct = await productRepository.createProduct(userId);

		if (!createdProduct) {
			console.log("Data not found");
			return NextResponse.json(
				{ message: "Data not found" },
				{ status: 404 }
			);
		}

		return NextResponse.json(createdProduct, {
			status: 201,
		});
	} catch (error) {
		console.error("Error occurred", error);
		return NextResponse.json(
			{ message: "Something went wrong" },
			{ status: 400 }
		);
	}
}