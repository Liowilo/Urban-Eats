import verifyApiRequest from "@/auth/verifyApiRequest";
import { ProductRepository } from "@/repositories/ProductRepository";
import { NextResponse } from "next/server";

export async function PUT(
	request,
	{ params: { productId } }
) {
	const authResult = await verifyApiRequest(request);
	if (!authResult.isValid) {
		return NextResponse.json({ message: "Unauthorized" }, { status: 401 });
	}

	const decoded = authResult.data;

	try {
		const productRepository = new ProductRepository();
		const data = await request.json();

		await productRepository.updateProductById(productId, data);

		return NextResponse.json(
			{ message: "Product updated successfully" },
			{ status: 200 }
		);
	} catch (error) {
		console.error("Error occurred", error);
		return NextResponse.json(
			{ message: "Something went wrong" },
			{ status: 400 }
		);
	}
}

export async function DELETE(request, { params: { productId } }) {
	const authResult = await verifyApiRequest(request);
	if (!authResult.isValid) {
		return NextResponse.json({ message: "Unauthorized" }, { status: 401 });
	}

	const decoded = authResult.data;

	try {
		const productRepository = new ProductRepository();
		await productRepository.deleteProductById(productId);
		return NextResponse.json(
			{ message: "Product deleted successfully" },
			{ status: 200 }
		);
	} catch (error) {
		console.error("Error occurred", error);
		return NextResponse.json(
			{ message: "Something went wrong" },
			{ status: 400 }
		);
	}
}