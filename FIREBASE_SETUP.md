# Firebase Configuration Setup

## Security Notice
The `google-services.json` file contains sensitive API keys and should never be committed to version control.

## Setup Instructions

1. **Get your Firebase configuration:**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Select your project (mind-verse)
   - Go to Project Settings → General → Your apps
   - Download the `google-services.json` file for Android

2. **Place the file:**
   - Copy the downloaded `google-services.json` to `android/app/`
   - The file is already added to `.gitignore` to prevent accidental commits

3. **Verify setup:**
   - The file should contain your actual API keys and project configuration
   - Never share or commit this file to any public repository

## Template
Use `google-services.json.template` as a reference for the required structure.
