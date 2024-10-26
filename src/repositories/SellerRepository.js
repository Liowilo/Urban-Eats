import { ObjectId } from "mongodb";
import { DATABASE_NAME } from "./constants";

export class SellerRepository {
	constructor() {
		this.databaseName = DATABASE_NAME;
		this.collectionName = "users";
	}

	async getProfileDataById(id) {
		return Promise.resolve({
			_id: new ObjectId(id),
			name: "Juan Pérezz",
			email: "juan.perez@example.com",
			phone: "555-1234",
			role: "customer",
			imagePath: "https://via.placeholder.com/150",
			createdAt: new Date(),
		});

		// const client = await clientPromise;
		// const db = client.db(this.databaseName);
		// const collection = db.collection(this.collectionName);
		// return collection.findOne({ _id: new ObjectId(id) });
	}

	async getStatsById(id) {
		return Promise.resolve({
			_id: new ObjectId(id),
			listedProducts: 5,
			totalRevenue: 4097.50,
			ordersAmount: 23,
		});

		// const client = await clientPromise;
		// const db = client.db(this.databaseName);
		// const collection = db.collection(this.collectionName);

		// return collection.findOne({ email });
	}

	async updateProfileDataById(id, data) {
		// const client = await clientPromise;
		// const db = client.db(this.databaseName);
		// const collection = db.collection(this.collectionName);

		// return collection.updateOne({ _id: new ObjectId(id) }, { $set: data });
	}


	async getProductsBySellerId(id) {
		return Promise.resolve([
			{
				id: 1,
				name: "Tacos al Pastor",
				description: "Tacos al Pastor",
				imagePath: "https://via.placeholder.com/150",
				price: 22.50
			},
			{
				id: 2,
				name: "Quesadillas",
				description: "Quesadillas",
				imagePath: "https://via.placeholder.com/150",
				price: 25.50
			},
			{
				id: 3,
				name: "Burritos",
				description: "Burritos",
				imagePath: "https://via.placeholder.com/150",
				price: 35.50
			},
			{
				id: 4,
				name: "Torta de Milanesa",
				description: "Torta de Milanesa",
				imagePath: "https://via.placeholder.com/150",
				price: 60.50
			},
		]);
	}
}
