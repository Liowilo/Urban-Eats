// src/app/api/user/route.js
import verifyApiRequest from "@/auth/verifyApiRequest";
import { ObjectId } from "mongodb";
import { NextResponse } from "next/server";
import { SellerRepository } from "@/repositories/SellerRepository";

export async function GET(request) {
	const authResult = await verifyApiRequest(request);
	if (!authResult.isValid) {
		return NextResponse.json({ message: "Unauthorized" }, { status: 401 });
	}

    const decoded = authResult.data;

	try {
		const userId = new ObjectId(decoded.userId);
        const sellerRepository = new SellerRepository();
        const stats = await sellerRepository.getStatsById(userId);

		if (!stats) {
			console.log("Data not found");
			return NextResponse.json(
				{ message: "Data not found" },
				{ status: 404 }
			);
		}

		return NextResponse.json(stats);
	} catch (error) {
		console.error("Error occurred", error);
		return NextResponse.json(
			{ message: "Something went wrong" },
			{ status: 400 }
		);
	}
}
