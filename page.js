export default function AdminPage() {
  return (
    <div style={{ padding: '50px', textAlign: 'center', fontFamily: 'Arial, sans-serif' }}>
      <h1 style={{ color: '#333', marginBottom: '20px' }}>🛡️ Admin Panel Test</h1>
      <p style={{ color: '#666', marginBottom: '30px' }}>Admin panel is working!</p>
      
      <div style={{ background: '#e8f5e8', padding: '20px', borderRadius: '10px', margin: '20px 0' }}>
        <h2>✅ Admin Panel Status: WORKING</h2>
        <p>Admin routes are functioning correctly!</p>
      </div>
      
      <div style={{ marginTop: '30px' }}>
        <a 
          href="/" 
          style={{ 
            background: '#0070f3', 
            color: 'white', 
            padding: '10px 20px', 
            textDecoration: 'none', 
            borderRadius: '5px'
          }}
        >
          Back to Main Store
        </a>
      </div>
      
      <div style={{ marginTop: '40px', fontSize: '14px', color: '#999' }}>
        <p>Admin Panel | Next.js 14 | Vercel</p>
        <p>Time: {new Date().toLocaleString()}</p>
      </div>
    </div>
  )
}