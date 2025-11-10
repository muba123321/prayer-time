#!/bin/bash

# Firestore Rules Deployment Script
# Run this from your project root directory

echo "🚀 Starting Firestore Rules Deployment..."
echo ""

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found. Installing..."
    npm install -g firebase-tools
    echo "✅ Firebase CLI installed"
else
    echo "✅ Firebase CLI found"
fi

echo ""
echo "📋 Current directory: $(pwd)"
echo ""

# Login to Firebase (will open browser)
echo "🔐 Logging in to Firebase..."
firebase login

echo ""
echo "🎯 Using Firebase project: gicc-f1622"
firebase use gicc-f1622

echo ""
echo "📤 Deploying Firestore rules..."
firebase deploy --only firestore:rules

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SUCCESS! Firestore rules deployed successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Create your first super admin (see ADMIN_SETUP_GUIDE.md)"
    echo "2. Test admin creation flow"
    echo "3. Verify security rules are working"
    echo ""
    echo "🎉 Your app is now secure with role-based access control!"
else
    echo ""
    echo "❌ Deployment failed. Please check the error above."
    echo ""
    echo "Common fixes:"
    echo "1. Make sure you're logged in: firebase login --reauth"
    echo "2. Check your project: firebase use gicc-f1622"
    echo "3. Verify firestore.rules file exists"
fi
