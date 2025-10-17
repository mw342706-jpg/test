import { NextResponse } from 'next/server'

export async function GET(request) {
  return NextResponse.json({ 
    message: 'API is working!', 
    timestamp: new Date().toISOString(),
    status: 'success'
  })
}

export async function POST(request) {
  return NextResponse.json({ 
    message: 'POST API is working!', 
    timestamp: new Date().toISOString(),
    status: 'success'
  })
}