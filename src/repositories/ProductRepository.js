import { ObjectId } from "mongodb";
import { DATABASE_NAME } from "./constants";

export class ProductRepository {
	constructor() {
		this.databaseName = DATABASE_NAME;
		this.collectionName = "products";
	}

	async createProduct(userId) {
		return Promise.resolve({
			_id: new ObjectId(),
			userId: userId,
			name: "Tacos al Pastor",
			description: "Tacos al Pastor",
			imagePath: "https://via.placeholder.com/150",
			price: 22.50
		});

		// const client = await clientPromise;
		// const db = client.db(this.databaseName);
		// const collection = db.collection(this.collectionName);

		// return collection.insertOne(data);
	}
	
	async updateProductById(id, data) {
		// const client = await clientPromise;
		// const db = client.db(this.databaseName);
		// const collection = db.collection(this.collectionName);

		// return collection.updateOne({ _id: new ObjectId(id) }, { $set: data });
	}

	async deleteProductById(id) {
		// const client = await clientPromise;
		// const db = client.db(this.databaseName);
		// const collection = db.collection(this.collectionName);

		// return collection.deleteOne({ _id: new ObjectId(id) });
	}
}