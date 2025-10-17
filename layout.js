import './globals.css'

export const metadata = {
  title: 'Festive Store - Holiday Shopping Made Easy',
  description: 'Your one-stop shop for festive decorations, gifts, and holiday essentials',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        {children}
      </body>
    </html>
  )
}