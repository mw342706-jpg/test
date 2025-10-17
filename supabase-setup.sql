-- Supabase Database Setup Script for Festive Store
-- Run this script in your Supabase SQL Editor

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url TEXT,
    category VARCHAR(50) DEFAULT 'christmas',
    stock INTEGER DEFAULT 10,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    product_id UUID REFERENCES products(id) ON DELETE SET NULL,
    product_name VARCHAR(255) NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(50),
    delivery_address TEXT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    paypal_order_id VARCHAR(255),
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create contact_messages table
CREATE TABLE IF NOT EXISTS contact_messages (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Allow public read products" ON products;
DROP POLICY IF EXISTS "Allow authenticated insert products" ON products;
DROP POLICY IF EXISTS "Allow authenticated update products" ON products;
DROP POLICY IF EXISTS "Allow authenticated delete products" ON products;

DROP POLICY IF EXISTS "Allow authenticated read orders" ON orders;
DROP POLICY IF EXISTS "Allow authenticated insert orders" ON orders;
DROP POLICY IF EXISTS "Allow authenticated update orders" ON orders;

DROP POLICY IF EXISTS "Allow public insert contact_messages" ON contact_messages;
DROP POLICY IF EXISTS "Allow authenticated read contact_messages" ON contact_messages;

-- Enable Row Level Security
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;

-- Create policies for products table
CREATE POLICY "Allow public read products" ON products
    FOR SELECT USING (true);

CREATE POLICY "Allow authenticated insert products" ON products
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated update products" ON products
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated delete products" ON products
    FOR DELETE USING (auth.role() = 'authenticated');

-- Create policies for orders table
CREATE POLICY "Allow authenticated read orders" ON orders
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated insert orders" ON orders
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated update orders" ON orders
    FOR UPDATE USING (auth.role() = 'authenticated');

-- Create policies for contact_messages table
CREATE POLICY "Allow public insert contact_messages" ON contact_messages
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow authenticated read contact_messages" ON contact_messages
    FOR SELECT USING (auth.role() = 'authenticated');

-- Insert sample products
INSERT INTO products (name, description, price, image_url, category, stock) VALUES
('Christmas Tree Decorations Set', 'Beautiful handcrafted ornaments for your Christmas tree', 29.99, 'https://images.unsplash.com/photo-1512389142860-9c449e58a543?w=400', 'christmas', 50),
('Halloween Pumpkin Carving Kit', 'Complete kit with tools and stencils for pumpkin carving', 19.99, 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400', 'halloween', 30),
('Festive String Lights', 'LED string lights perfect for holiday decorations', 24.99, 'https://images.unsplash.com/photo-1512389142860-9c449e58a543?w=400', 'christmas', 25),
('Spooky Halloween Costume', 'Classic Halloween costume for adults', 39.99, 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400', 'halloween', 15),
('Holiday Gift Box Set', 'Elegant gift boxes for holiday presents', 15.99, 'https://images.unsplash.com/photo-1512389142860-9c449e58a543?w=400', 'christmas', 40),
('Halloween Decorations Pack', 'Spooky decorations for Halloween parties', 22.99, 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400', 'halloween', 20)
ON CONFLICT (id) DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products(created_at);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at);
CREATE INDEX IF NOT EXISTS idx_contact_messages_created_at ON contact_messages(created_at);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
DROP TRIGGER IF EXISTS update_products_updated_at ON products;
CREATE TRIGGER update_products_updated_at
    BEFORE UPDATE ON products
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_orders_updated_at ON orders;
CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;

-- Set up realtime for products table (optional)
ALTER PUBLICATION supabase_realtime ADD TABLE products;
ALTER PUBLICATION supabase_realtime ADD TABLE orders;
ALTER PUBLICATION supabase_realtime ADD TABLE contact_messages;

-- Success message
SELECT 'Database setup completed successfully!' as status;


