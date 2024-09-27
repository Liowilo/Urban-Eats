'use client'

import { useEffect, useCallback, useState } from 'react'
import { useRouter } from 'next/navigation'
import Image from 'next/image'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent } from "@/components/ui/card"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { SearchIcon, ShoppingBag, UserIcon, X, LogOut } from 'lucide-react'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import Link from "next/link"

export default function Dashboard() {
    const [userEmail, setUserEmail] = useState("")
    const [userImage, setUserImage] = useState("/placeholder.svg")
    const [searchQuery, setSearchQuery] = useState('')
    const [cart, setCart] = useState([])
    const [isLoading, setIsLoading] = useState(true)
    const [error, setError] = useState(null)
    const [isLoggingOut, setIsLoggingOut] = useState(false)
    const router = useRouter()

    const fetchUserData = useCallback(async () => {
        setIsLoading(true)
        setError(null)
        try {
            console.log("Fetching user data...")
            const response = await fetch('/api/user', {
                credentials: 'include'
            });
            console.log("Response status:", response.status)
            const responseData = await response.text();
            console.log("Response data:", responseData);
            
            if (response.ok) {
                const userData = JSON.parse(responseData);
                console.log("User data:", userData)
                setUserEmail(userData.email)
                setUserImage(userData.image || "/placeholder.svg")
            } else {
                const errorData = JSON.parse(responseData);
                throw new Error(errorData.message || 'Failed to fetch user data');
            }
        } catch (error) {
            console.error('Error fetching user data:', error)
            setError(error.message)
            if (error.message === 'User not found') {
                // Si el usuario no se encuentra, redirigimos al login
                router.push('/login-register');
            }
        } finally {
            setIsLoading(false)
        }
    }, [router])

    useEffect(() => {
        fetchUserData()
    }, [fetchUserData])

    const handleLogout = async () => {
        setIsLoggingOut(true)
        try {
            const response = await fetch('/api/auth/logout', { 
                method: 'POST', 
                credentials: 'include' 
            });
            if (response.ok) {
                router.push('/login-register')
            } else {
                throw new Error('Logout failed');
            }
        } catch (error) {
            console.error('Logout error:', error);
            setError('Failed to logout. Please try again.');
        } finally {
            setIsLoggingOut(false)
        }
    }

    if (isLoading) return <div>Loading...</div>
    if (error) return (
        <div>
            <h1>Error: {error}</h1>
            <button onClick={fetchUserData}>Retry</button>
            <button onClick={() => router.push('/login-register')}>Go to Login</button>
        </div>
    )

    const vendors = [
        { id: 1, name: "Tacos Don Pedro", productCount: 3 },
        { id: 2, name: "La Fonda de Doña Mari", productCount: 2 },
        { id: 3, name: "Jugos y Licuados El Oasis", productCount: 1 },
    ]

    const products = [
        { id: 1, name: "Tacos al Pastor", price: 50, image: "/placeholder.svg", vendorId: 1 },
        { id: 2, name: "Quesadillas", price: 40, image: "/placeholder.svg", vendorId: 1 },
        { id: 3, name: "Burritos", price: 45, image: "/placeholder.svg", vendorId: 1 },
        { id: 4, name: "Torta de Milanesa", price: 60, image: "/placeholder.svg", vendorId: 2 },
        { id: 5, name: "Papas Fritas", price: 25, image: "/placeholder.svg", vendorId: 2 },
        { id: 6, name: "Agua de Horchata", price: 20, image: "/placeholder.svg", vendorId: 3 },
    ]

    const addToCart = (product) => {
        if (cart.length === 0 || cart[0].vendorId === product.vendorId) {
            setCart([...cart, product])
        } else {
            alert("Solo puedes agregar productos del mismo vendedor por pedido.")
        }
    }

    const VendorProductsDialog = ({ vendor, products }) => (
        <Dialog>
            <DialogTrigger asChild>
                <Button className="w-full mt-2 bg-green-500 hover:bg-green-600 text-white">Ver más</Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-white">
                <DialogHeader className="flex justify-between items-center">
                    <DialogTitle className="text-black text-xl font-bold">{vendor.name}</DialogTitle>
                    <DialogTrigger asChild>
                        <Button variant="ghost" className="p-0">
                            <X className="h-4 w-4" />
                        </Button>
                    </DialogTrigger>
                </DialogHeader>
                <div className="grid gap-4 py-4">
                    {products.map((product) => (
                        <Card key={product.id} className="bg-gray-100 border-gray-200">
                            <CardContent className="p-4 flex items-center justify-between">
                                <div>
                                    <h3 className="font-semibold text-black">{product.name}</h3>
                                    <p className="text-green-600 font-bold">${product.price}</p>
                                </div>
                                <Button
                                    onClick={() => addToCart(product)}
                                    className="bg-green-500 hover:bg-green-600 text-white"
                                >
                                    Agregar
                                </Button>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            </DialogContent>
        </Dialog>
    )

    return (
        <div className="min-h-screen bg-green-50">
            <header className="bg-green-600 text-white p-4">
                <div className="container mx-auto flex justify-between items-center">
                    <Link className="flex items-center justify-center" href="#">
                        <ShoppingBag className="h-8 w-8 text-white" />
                        <span className="ml-2 text-3xl font-bold text-white">UrbanEats</span>
                    </Link>
                    <div className="flex items-center space-x-4">
                        <Avatar className="h-10 w-10">
                            <AvatarImage src={userImage} alt="Foto de perfil" />
                            <AvatarFallback><UserIcon /></AvatarFallback>
                        </Avatar>
                        <span className="hidden sm:inline">{userEmail}</span>
                        <Button
                            onClick={handleLogout}
                            disabled={isLoggingOut}
                            variant="ghost"
                            className="text-white hover:text-green-200 flex items-center p-2"
                        >
                            <LogOut className="h-6 w-6 sm:mr-2" />
                            <span className="hidden sm:inline">{isLoggingOut ? 'Cerrando sesión...' : 'Cerrar sesión'}</span>
                        </Button>
                    </div>
                </div>
            </header>

            <main className="container mx-auto p-4">
                <div className="mb-6">
                    <div className="relative">
                        <SearchIcon className="absolute left-2 top-3 h-4 w-4 text-gray-500" />
                        <Input
                            type="search"
                            placeholder="Buscar vendedores..."
                            className="pl-8 w-full"
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                        />
                    </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div className="md:col-span-2">
                        <h2 className="text-xl font-semibold mb-4 text-black">Vendedores Disponibles</h2>
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            {vendors
                                .filter(vendor => vendor.name.toLowerCase().includes(searchQuery.toLowerCase()))
                                .map((vendor) => {
                                    const vendorProducts = products.filter(product => product.vendorId === vendor.id)
                                    return (
                                        <Card key={vendor.id} className="bg-white">
                                            <CardContent className="p-4">
                                                <Image
                                                    src="/placeholder.svg"
                                                    alt={vendor.name}
                                                    width={300}
                                                    height={200}
                                                    className="w-full h-40 object-cover mb-2 rounded"
                                                />
                                                <h3 className="font-semibold text-black">{vendor.name}</h3>
                                                <p className="text-sm text-gray-500 mb-2">{vendor.productCount} productos</p>
                                                <VendorProductsDialog vendor={vendor} products={vendorProducts} />
                                            </CardContent>
                                        </Card>
                                    )
                                })
                            }
                        </div>
                    </div>

                    <div>
                        <h2 className="text-xl font-semibold mb-4 text-black">Carrito de Compras</h2>
                        <Card className="bg-white">
                            <CardContent className="p-4">
                                {cart.length === 0 ? (
                                    <p className="text-black">Tu carrito está vacío</p>
                                ) : (
                                    <>
                                        {cart.map((item) => (
                                            <div key={item.id} className="flex justify-between items-center mb-2">
                                                <span className="text-black">{item.name} - ${item.price}</span>
                                                <Button
                                                    variant="ghost"
                                                    size="sm"
                                                    onClick={() => setCart(cart.filter(cartItem => cartItem.id !== item.id))}
                                                    className="text-black hover:text-red-600"
                                                >
                                                    Eliminar
                                                </Button>
                                            </div>
                                        ))}
                                        <div className="mt-4 pt-2 border-t">
                                            <p className="font-semibold text-black">Total: ${cart.reduce((sum, item) => sum + item.price, 0)}</p>
                                        </div>
                                        <Button className="w-full mt-4 bg-green-500 hover:bg-green-600 text-white">
                                            Proceder al pago
                                        </Button>
                                    </>
                                )}
                            </CardContent>
                        </Card>
                    </div>
                </div>
            </main>
        </div>
    )
}