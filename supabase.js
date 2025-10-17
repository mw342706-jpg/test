import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://gzsajsobcgdwgogabhun.supabase.co'
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd6c2Fqc29iY2dkd2dvZ2FiaHVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMDk0ODIsImV4cCI6MjA3NTU4NTQ4Mn0.IezTpTPYX9DGs4cT62qfpMxi66GqUprAgTfmEnEPdF4'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Initialize database tables
export async function initializeDatabase() {
  try {
    // Check if products table exists
    const { data: products, error: productsError } = await supabase
      .from('products')
      .select('*')
      .limit(1)

    if (productsError && productsError.code === 'PGRST116') {
      console.log('Database not initialized. Please run the SQL setup script.')
      return false
    }

    return true
  } catch (error) {
    console.error('Database initialization error:', error)
    return false
  }
}

