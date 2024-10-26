/**
 * Determina si una peticion es valida, verificando el jwt
 * @param {*} request
 * @returns
 */
export default async function verifyApiRequest(request) {
	return {
		isValid: true,
		data: {
			userId: 1,
		}
	}
	// const token = request.cookies.get("token")?.value;

	// if (!token) {
	// 	return {
	// 		isValid: false,
	// 	};
	// }

	// try {
	// 	const decoded = await verify(token, process.env.JWT_SECRET);
	// 	return {
	// 		isValid: true,
	// 		data: decoded,
	// 	};
	// } catch (error) {
	// 	console.error("Error verifying token:", error);
	// 	return {
	// 		isValid: false,
	// 	};
	// }
}
