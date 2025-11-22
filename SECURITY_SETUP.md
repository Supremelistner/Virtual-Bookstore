# Security Setup Guide

## Overview
This guide helps you secure sensitive configuration data using environment variables instead of hardcoded values.

## Files Created
- `.gitignore` - Excludes sensitive files from version control
- `application-template.properties` - Template files for each service
- `.env.template` - Environment variables template

## Setup Instructions

### 1. Environment Variables Setup

Copy `.env.template` to `.env` and update with your actual values:
```bash
cp .env.template .env
```

Edit `.env` with your actual credentials:
```properties
DB_USERNAME=your_actual_db_username
DB_PASSWORD=your_actual_db_password
JWT_SECRET=your_256_bit_jwt_secret_key
MAIL_USERNAME=your_actual_email@domain.com
MAIL_PASSWORD=your_actual_app_password
RAZORPAY_KEY_ID=your_actual_razorpay_key
RAZORPAY_KEY_SECRET=your_actual_razorpay_secret
```

### 2. Application Properties Setup

For each service, copy the template to create your actual configuration:

```bash
# BuyerService
cp BuyerService/src/main/resources/application-template.properties BuyerService/src/main/resources/application.properties

# Profile Service
cp profile/src/main/resources/application-template.properties profile/src/main/resources/application.properties

# Seller-Service
cp Seller-Service/src/main/resources/application-template.properties Seller-Service/src/main/resources/application.properties

# Discovery Service
cp Discoveryclient/src/main/resources/application-template.properties Discoveryclient/src/main/resources/application.properties

# Gateway Service
cp gateway/src/main/resources/application-template.properties gateway/src/main/resources/application.properties
```

### 3. Set Environment Variables

#### Windows (Command Prompt)
```cmd
set JWT_SECRET=your_jwt_secret_here
set DB_PASSWORD=your_db_password
set MAIL_PASSWORD=your_email_password
set RAZORPAY_KEY_SECRET=your_razorpay_secret
```

#### Windows (PowerShell)
```powershell
$env:JWT_SECRET="your_jwt_secret_here"
$env:DB_PASSWORD="your_db_password"
$env:MAIL_PASSWORD="your_email_password"
$env:RAZORPAY_KEY_SECRET="your_razorpay_secret"
```

#### Linux/Mac
```bash
export JWT_SECRET="your_jwt_secret_here"
export DB_PASSWORD="your_db_password"
export MAIL_PASSWORD="your_email_password"
export RAZORPAY_KEY_SECRET="your_razorpay_secret"
```

### 4. IDE Configuration

#### IntelliJ IDEA
1. Go to Run Configuration
2. Add Environment Variables in the Environment Variables section
3. Load from `.env` file or set individually

#### Eclipse
1. Right-click project → Properties
2. Run/Debug Settings → Environment
3. Add environment variables

### 5. Production Deployment

#### Docker
Create `docker-compose.yml` with environment variables:
```yaml
version: '3.8'
services:
  profile-service:
    image: profile-service:latest
    environment:
      - JWT_SECRET=${JWT_SECRET}
      - DB_PASSWORD=${DB_PASSWORD}
      - MAIL_PASSWORD=${MAIL_PASSWORD}
```

#### Kubernetes
Create ConfigMap and Secrets:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
data:
  jwt-secret: <base64-encoded-secret>
  db-password: <base64-encoded-password>
```

## Security Best Practices

### 1. JWT Secret
- Use a strong, randomly generated 256-bit key
- Never commit to version control
- Rotate regularly in production

### 2. Database Credentials
- Use strong passwords
- Create dedicated database users with minimal privileges
- Use connection pooling and SSL

### 3. Email Credentials
- Use app-specific passwords
- Enable 2FA on email accounts
- Consider using OAuth2 instead of passwords

### 4. API Keys (Razorpay)
- Use test keys for development
- Secure production keys in environment variables
- Monitor usage and set up alerts

### 5. File Paths
- Use absolute paths outside web root
- Set proper file permissions
- Consider cloud storage for production

## Verification

Test that environment variables are working:
1. Start services with environment variables set
2. Check logs for successful database connection
3. Verify JWT token generation works
4. Test email functionality
5. Confirm file upload/download works

## Troubleshooting

### Environment Variables Not Loading
- Verify variables are set in current session
- Check IDE run configuration
- Restart IDE after setting system variables

### Default Values Used
- Check variable names match exactly
- Verify no typos in variable names
- Ensure variables are exported/set correctly

### Still Seeing Hardcoded Values
- Confirm you're using the correct application.properties
- Check if template file is being used instead
- Verify Spring profile is not overriding values