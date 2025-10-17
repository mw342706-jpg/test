# 🚀 Vercel Deployment Guide

## 🔧 **FIXING 404 ERROR**

### Step 1: Update Environment Variables in Vercel

1. Go to your Vercel dashboard
2. Select your project (`festivonnn`)
3. Go to **Settings** → **Environment Variables**
4. Add these variables:

```
NEXT_PUBLIC_SUPABASE_URL=https://gzsajsobcgdwgogabhun.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd6c2Fqc29iY2dkd2dvZ2FiaHVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMDk0ODIsImV4cCI6MjA3NTU4NTQ4Mn0.IezTpTPYX9DGs4cT62qfpMxi66GqUprAgTfmEnEPdF4
NEXT_PUBLIC_PAYPAL_CLIENT_ID=Ae5Vs8RNCc0Oi9d4pKNYnr_GPP8HCrT4aLE7XIBDGqwvGdG3BviVxseHnKgDX1eCzS0JECRe2OjPI8Pr
PAYPAL_CLIENT_ID=Ae5Vs8RNCc0Oi9d4pKNYnr_GPP8HCrT4aLE7XIBDGqwvGdG3BviVxseHnKgDX1eCzS0JECRe2OjPI8Pr
PAYPAL_SECRET=ENQwmbXklqhxyluO4NM9MHuQqakldtUZ3GlodDSWZ_-d0w-UR0LbMc3zx_eyXfuw0uCAS6Muik_Untt7
NEXT_PUBLIC_BASE_URL=https://festivonnn.vercel.app
NEXT_PUBLIC_ADMIN_EMAIL=bunn9y6@gmail.com
```

### Step 2: Redeploy

1. Go to **Deployments** tab
2. Click **Redeploy** on the latest deployment
3. Wait for deployment to complete

### Step 3: Check Build Logs

If still getting 404:
1. Go to **Functions** tab
2. Check for any build errors
3. Look for missing dependencies

## 🔧 **ALTERNATIVE: Manual Upload**

### Option 1: ZIP Upload to GitHub

1. **Create ZIP file:**
   ```bash
   # Remove unnecessary files first
   rm -rf .next node_modules
   
   # Create ZIP
   zip -r fn1-festive-store.zip . -x "*.git*" "*.next*" "node_modules/*"
   ```

2. **Upload to GitHub:**
   - Go to GitHub.com
   - Create new repository: `fn1-festive-store`
   - Upload ZIP file
   - Extract files
   - Commit and push

3. **Connect to Vercel:**
   - Import from GitHub
   - Add environment variables
   - Deploy

### Option 2: Direct Vercel Upload

1. **Install Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Deploy:**
   ```bash
   cd fn1
   vercel --prod
   ```

## 🐛 **Common Issues & Solutions**

### Issue 1: 404 Error
- **Cause:** Missing environment variables
- **Solution:** Add all env vars in Vercel dashboard

### Issue 2: Build Failed
- **Cause:** Missing dependencies
- **Solution:** Check package.json, run `npm install`

### Issue 3: API Routes Not Working
- **Cause:** Incorrect base URL
- **Solution:** Update `NEXT_PUBLIC_BASE_URL` to your Vercel domain

### Issue 4: Images Not Loading
- **Cause:** Image domains not configured
- **Solution:** Add domains to `next.config.js`

## ✅ **Quick Fix Steps**

1. **Update Environment Variables** (Most Important!)
2. **Redeploy** from Vercel dashboard
3. **Check** `https://festivonnn.vercel.app`
4. **Test** admin panel at `https://festivonnn.vercel.app/admin`

## 🎯 **Expected Result**

After fixing:
- ✅ Main store loads at root URL
- ✅ Admin panel accessible at `/admin`
- ✅ All features working
- ✅ PayPal integration working
- ✅ Database connected

## 📞 **Need Help?**

If still having issues:
1. Check Vercel build logs
2. Verify environment variables
3. Test locally first: `npm run dev`
4. Check Supabase connection
