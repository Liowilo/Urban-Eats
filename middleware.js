// middleware.js
import { NextResponse } from 'next/server'

export function middleware(request) {
    const token = request.cookies.get('token')?.value
    const { pathname } = request.nextUrl

    console.log("Middleware called for path:", pathname)
    console.log("Token present:", !!token)

    // Paths that are always accessible
    const publicPaths = ['/login-register', '/api/auth/login', '/api/auth/register']

    // Allow access to all API routes
    if (pathname.startsWith('/api/')) {
        console.log("API route, allowing access")
        return NextResponse.next()
    }

    // Check if the requested path is public
    if (publicPaths.includes(pathname)) {
        console.log("Public path, allowing access")
        return NextResponse.next()
    }

    // If there's no token and the path is not public, redirect to login
    if (!token) {
        console.log("No token, redirecting to login")
        return NextResponse.redirect(new URL('/login-register', request.url))
    }

    // If there's a token, allow the request
    console.log("Token present, allowing access")
    return NextResponse.next()
}

export const config = {
    matcher: [
        '/((?!_next/static|_next/image|favicon.ico).*)',
    ],
}