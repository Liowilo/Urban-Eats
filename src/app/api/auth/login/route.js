// src/app/api/auth/login/route.js
import { NextResponse } from 'next/server';
import clientPromise from '@/lib/mongodb';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

export async function POST(request) {
    console.log("Login route called");
    try {
        const { email, password } = await request.json();
        console.log("Email:", email);

        if (!email || !password) {
            console.log("Missing email or password");
            return NextResponse.json({ message: 'Email and password are required' }, { status: 400 });
        }

        const client = await clientPromise;
        console.log("MongoDB connected");
        const db = client.db('Urban-Eats');

        const user = await db.collection('users').findOne({ email });
        console.log("User found:", !!user);

        if (!user) {
            return NextResponse.json({ message: 'Invalid credentials' }, { status: 400 });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        console.log("Password match:", isMatch);

        if (!isMatch) {
            return NextResponse.json({ message: 'Invalid credentials' }, { status: 400 });
        }

        const token = jwt.sign({ userId: user._id.toString() }, process.env.JWT_SECRET, { expiresIn: '1d' });
        console.log("Token generated");

        const response = NextResponse.json({ message: 'Login successful' }, { status: 200 });
        response.cookies.set('token', token, {
            httpOnly: true,
            secure: process.env.NODE_ENV !== 'development',
            sameSite: 'strict',
            maxAge: 86400 // 1 day
        });

        console.log("Response prepared");
        return response;
    } catch (error) {
        console.error('Login error:', error);
        return NextResponse.json({ message: 'Error logging in', error: error.message }, { 
            status: 500,
            headers: {
                "Access-Control-Allow-Origin": "http://localhost:3000",
                "Access-Control-Allow-Credentials": "true",
                "Access-Control-Allow-Methods": "GET,OPTIONS,PATCH,DELETE,POST,PUT",
                "Access-Control-Allow-Headers": "X-CSRF-Token, X-Requested-With, Accept, Content-Type, Authorization"
            } 
        });
    }
}