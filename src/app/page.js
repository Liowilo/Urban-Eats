"use client";

import React, { useState, useRef, useEffect } from 'react'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { ShoppingBag, Utensils, Smartphone, Book, Menu, X } from "lucide-react"
import Image from "next/image"
import Link from "next/link"

export default function LandingPage() {
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const menuRef = useRef(null)
  useEffect(() => {
    if (isMenuOpen) {
      menuRef.current.style.maxHeight = `${menuRef.current.scrollHeight}px`
    } else {
      menuRef.current.style.maxHeight = '0px'
    }
  }, [isMenuOpen])
  return (
    <div className="flex flex-col min-h-screen bg-green-50">
      <header className="px-4 lg:px-6 h-16 flex items-center justify-between bg-green-600">
        <Link className="flex items-center justify-center" href="#">
          <ShoppingBag className="h-8 w-8 text-white" />
          <span className="ml-2 text-3xl font-bold text-white">UrbanEats</span>
        </Link>
        <button
          className="lg:hidden text-white"
          onClick={() => setIsMenuOpen(!isMenuOpen)}
        >
          {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
        </button>
        <nav
          ref={menuRef}
          className={`
          lg:flex flex-col lg:flex-row
          absolute lg:relative top-16 lg:top-0 left-0 
          w-full lg:w-auto 
          bg-green-600 lg:bg-transparent
          items-center 
          overflow-hidden transition-all duration-300 ease-in-out
          lg:overflow-visible lg:max-h-full
        `}
        >
          <div className="flex flex-col lg:flex-row items-center space-y-4 lg:space-y-0 lg:space-x-6 py-4 lg:py-0">
            <Link className="text-base font-medium text-white hover:text-green-200 transition-colors" href="#">
              Inicio
            </Link>
            <Link className="text-base font-medium text-white hover:text-green-200 transition-colors" href="#">
              Acerca de
            </Link>
            <Link className="text-base font-medium text-white hover:text-green-200 transition-colors" href="#">
              Servicios
            </Link>
            <Link className="text-base font-medium text-white hover:text-green-200 transition-colors" href="#">
              Contacto
            </Link>
            <Button className="bg-white text-black hover:bg-green-100 hover:text-white transition-colors">
              Registrarse
            </Button>
            <Button className="bg-transparent text-white border border-white hover:bg-white hover:text-green-700 transition-colors">
              Iniciar sesión
            </Button>
          </div>
        </nav>
      </header>
      <main className="flex-1">
        <section className="w-full py-12 md:py-24 lg:py-32 xl:py-48 bg-green-500">
          <div className="container mx-auto px-4 md:px-6">
            <div className="flex flex-col items-center space-y-4 text-center">
              <div className="space-y-2">
                <h1 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl lg:text-6xl/none text-white">
                  Bienvenido a UrbanEats
                </h1>
                <p className="mx-auto max-w-[700px] text-green-100 md:text-xl">
                  ¡La plataforma definitiva para que los estudiantes de la FES Cuautitlán vendan y compren productos, servicios y deliciosa comida!
                </p>
              </div>
              <div className="space-x-4">
                <Button className="bg-white text-black hover:bg-green-700 hover:text-white transition-colors">
                  Comenzar
                </Button>
                <Button
                  variant="outline"
                  className="bg-transparent text-white border-white hover:bg-white hover:text-green-700 transition-colors"
                >
                  Saber más
                </Button>
              </div>
            </div>
          </div>
        </section>
        <section className="w-full py-12 md:py-24 lg:py-32 bg-white">
          <div className="container mx-auto px-4 md:px-6">
            <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl text-green-600 text-center mb-8">
              Nuestros Servicios
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8 justify-items-center">
              <div className="flex flex-col items-center text-center max-w-sm">
                <Utensils className="h-12 w-12 text-green-500 mb-4" />
                <h3 className="text-xl font-bold text-green-600 mb-2">Comida Deliciosa</h3>
                <p className="text-gray-600">Descubre una variedad de platos deliciosos de tus compañeros estudiantes.</p>
              </div>
              <div className="flex flex-col items-center text-center max-w-sm">
                <ShoppingBag className="h-12 w-12 text-green-500 mb-4" />
                <h3 className="text-xl font-bold text-green-600 mb-2">Productos Estudiantiles</h3>
                <p className="text-gray-600">Encuentra productos únicos creados por talentosos estudiantes de la FES Cuautitlán.</p>
              </div>
              <div className="flex flex-col items-center text-center max-w-sm">
                <Book className="h-12 w-12 text-green-500 mb-4" />
                <h3 className="text-xl font-bold text-green-600 mb-2">Servicios Académicos</h3>
                <p className="text-gray-600">Accede a tutoría, intercambio de apuntes y otros servicios de apoyo académico.</p>
              </div>
            </div>
          </div>
        </section>
        <section className="w-full py-12 md:py-24 lg:py-32 bg-green-100">
          <div className="container mx-auto px-4 md:px-6">
            <div className="grid items-center gap-6 lg:grid-cols-2 lg:gap-12">
              <Image
                src="/img/UrbanEatsLogo.webp"
                width={400}
                height={400}
                alt="Aplicación Móvil de UrbanEats"
                className="mx-auto aspect-square overflow-hidden rounded-xl object-cover object-center sm:w-full lg:order-last"
              />
              <div className="flex flex-col justify-center space-y-4">
                <div className="space-y-2">
                  <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl text-green-600">
                    Obtén la App de UrbanEats
                  </h2>
                  <p className="max-w-[600px] text-gray-600 md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
                    Descarga nuestra aplicación móvil para acceder a UrbanEats en cualquier momento. ¡Compra, vende y descubre increíbles ofertas de tus compañeros estudiantes donde quiera que estés!
                  </p>
                </div>
                <div className="flex flex-col gap-2 min-[400px]:flex-row">
                  <Button className="bg-green-600 text-white hover:bg-green-700 inline-flex items-center justify-center">
                    <Smartphone className="mr-2 h-5 w-5" />
                    Descargar Ahora
                  </Button>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section className="w-full py-12 md:py-24 lg:py-32 bg-white">
          <div className="container mx-auto px-4 md:px-6">
            <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl text-green-600 text-center mb-8">
              Únete a UrbanEats Hoy
            </h2>
            <div className="mx-auto w-full max-w-sm space-y-2">
              <form className="flex flex-col gap-2">
                <Input type="email" placeholder="Ingresa tu correo electrónico" />
                <Button type="submit" className="bg-green-600 text-white hover:bg-green-700">Registrarse</Button>
              </form>
              <p className="text-xs text-center text-gray-500">
                Al registrarte, aceptas nuestros Términos y Condiciones y Política de Privacidad.
              </p>
            </div>
          </div>
        </section>
      </main>
      <footer className="flex flex-col gap-2 sm:flex-row py-6 w-full shrink-0 items-center justify-between px-4 md:px-6 border-t bg-green-600">
        <p className="text-xs text-green-100">© 2024 UrbanEats. Todos los derechos reservados.</p>
        <nav className="flex gap-4 sm:gap-6">
          <Link className="text-xs hover:underline underline-offset-4 text-green-100" href="#">
            Términos de Servicio
          </Link>
          <Link className="text-xs hover:underline underline-offset-4 text-green-100" href="#">
            Privacidad
          </Link>
        </nav>
      </footer>
    </div>
  )
}