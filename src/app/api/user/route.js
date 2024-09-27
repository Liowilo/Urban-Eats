// src/app/api/user/route.js
import { NextResponse } from 'next/server';
import { verify } from 'jsonwebtoken';
import clientPromise from '@/lib/mongodb';
import { ObjectId } from 'mongodb';

export async function GET(request) {
    console.log("User API called");

    const token = request.cookies.get('token')?.value;

    console.log("Token from cookie:", token);

    if (!token) {
        console.log("No token provided");
        return NextResponse.json({ message: 'No token provided' }, { status: 401 });
    }

    try {
        console.log("Verifying token...");
        const decoded = verify(token, process.env.JWT_SECRET);
        console.log("Decoded token:", decoded);

        const client = await clientPromise;
        const db = client.db('Urban-Eats');
        
        // Asegúrate de que el userId es un ObjectId válido
        const userId = new ObjectId(decoded.userId);
        console.log("Searching for user with ID:", userId);

        const user = await db.collection('users').findOne({ _id: userId });

        if (!user) {
            console.log("User not found");
            return NextResponse.json({ message: 'User not found' }, { status: 404 });
        }

        console.log("User found:", user.email);
        return NextResponse.json({ email: user.email, image: user.image });
    } catch (error) {
        console.error('Error verifying token or finding user:', error);
        return NextResponse.json({ message: 'Invalid token or user not found' }, { status: 401 });
    }
}