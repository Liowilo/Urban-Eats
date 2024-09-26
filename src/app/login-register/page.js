'use client'
import { useState } from 'react'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"

export default function LoginRegister() {
  const [activeTab, setActiveTab] = useState('login')
  
  const handleSubmit = (event) => {
    event.preventDefault()
    console.log('Formulario enviado')
  }

  return (
    <div className="min-h-screen bg-green-50 flex items-center justify-center p-4">
      <Card className="w-full max-w-md shadow-lg bg-white">
        <CardHeader className="text-center space-y-2">
        <CardTitle className="text-3xl font-bold">
            <span className="text-green-800">Urban</span>
            <span className="text-green-500">Eats</span>
          </CardTitle>
          <CardDescription className="text-gray-600">
            Conectando estudiantes de la FES Cuautitlán con productos y servicios locales
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
            <TabsList className="grid w-full grid-cols-2 mb-4 bg-gray-100 p-1 rounded-md">
              <TabsTrigger 
                value="login" 
                className="rounded-md py-2 text-gray-700 data-[state=active]:bg-white data-[state=active]:text-green-800 data-[state=active]:shadow-sm flex items-center justify-center"
              >
                Iniciar Sesión
              </TabsTrigger>
              <TabsTrigger 
                value="register" 
                className="rounded-md py-2 text-gray-700 data-[state=active]:bg-white data-[state=active]:text-green-800 data-[state=active]:shadow-sm flex items-center justify-center"
              >
                Registrarse
              </TabsTrigger>
            </TabsList>
            <TabsContent value="login">
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="email" className="text-black">Correo Electrónico</Label>
                  <Input id="email" type="email" placeholder="tu@ejemplo.com" required className="border-gray-300 text-black" />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="password" className="text-black">Contraseña</Label>
                  <Input id="password" type="password" required className="border-gray-300 text-black" />
                </div>
                <Button type="submit" className="w-full bg-green-600 hover:bg-green-700 text-white">
                  Iniciar Sesión
                </Button>
              </form>
            </TabsContent>
            <TabsContent value="register">
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="register-email" className="text-black">Correo Electrónico</Label>
                  <Input id="register-email" type="email" placeholder="tu@ejemplo.com" required className="border-gray-300 text-black" />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="register-password" className="text-black">Contraseña</Label>
                  <Input id="register-password" type="password" required className="border-gray-300 text-black" />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="confirm-password" className="text-black">Confirmar Contraseña</Label>
                  <Input id="confirm-password" type="password" required className="border-gray-300 text-black" />
                </div>
                <Button type="submit" className="w-full bg-green-600 hover:bg-green-700 text-white">
                  Registrarse
                </Button>
              </form>
            </TabsContent>
          </Tabs>
        </CardContent>
        <CardFooter className="text-center text-sm text-green-600">
          UrbanEats - Conectando la comunidad estudiantil
        </CardFooter>
      </Card>
    </div>
  )
}