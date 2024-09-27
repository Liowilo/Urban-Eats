import localFont from "next/font/local";
import "./globals.css";

const geistSans = localFont({
  src: "./fonts/GeistVF.woff",
  variable: "--font-geist-sans",
  weight: "100 900",
});
const geistMono = localFont({
  src: "./fonts/GeistMonoVF.woff",
  variable: "--font-geist-mono",
  weight: "100 900",
});

export const metadata = {
  title: "UrbanEats",
  description: "Venta y compra estudiantes de la FES Cuautitlán",
  icons: {
    icon: '/img/favicon.ico', // Asumiendo que has movido favicon.ico a public/img
    apple: '/img/apple-icon.png',
    shortcut: '/img/shortcut-icon.png',
  }
};

export default function RootLayout({ children }) {
  return (
    <html lang="es">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        {children}
      </body>
    </html>
  );
}
