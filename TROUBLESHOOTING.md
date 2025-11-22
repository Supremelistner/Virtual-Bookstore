# Virtual BookStore - Troubleshooting Guide

## Fixed Issues

### 1. Spring Boot Version Inconsistencies ✅
- **Problem**: Different Spring Boot versions across services (3.3.3, 3.3.4, 3.3.5)
- **Solution**: Standardized all services to Spring Boot 3.3.5

### 2. Duplicate Dependencies ✅
- **Problem**: Duplicate tracing dependencies in BuyerService
- **Solution**: Removed duplicate micrometer and zipkin dependencies

### 3. Configuration Typos ✅
- **Problem**: `pring.zipkin.check-timeout` instead of `spring.zipkin.check-timeout`
- **Solution**: Fixed typos in all application.properties files

### 4. Path Configuration Inconsistency ✅
- **Problem**: `Book.Chapters` instead of `path.Chapters` in profile service
- **Solution**: Standardized path configuration naming

### 5. Missing Dependencies ✅
- **Problem**: Missing Eureka client in Gateway, JWT dependencies in services
- **Solution**: Added required dependencies to all services

### 6. Gateway Configuration Error ✅
- **Problem**: Incorrect YAML structure (`route:` instead of `routes:`)
- **Solution**: Fixed gateway routing configuration and added missing routes

### 7. Critical Bug in BuyerService ✅
- **Problem**: `getSellerinventory()` called instead of `getUserInventory()`
- **Solution**: Fixed method call in buyerrid endpoint

### 8. Missing Annotations ✅
- **Problem**: Missing `@RequestParam` annotations in controller methods
- **Solution**: Added proper annotations for request parameters

## Startup Instructions

### Prerequisites
1. PostgreSQL running on localhost:5432 with database 'testcase'
2. Java 17 installed
3. Maven installed

### Startup Order
1. **Discovery Service** (Port 8761) - Must start first
2. **Profile Service** (Port 8088)
3. **Seller Service** (Port 8081)
4. **Buyer Service** (Port 8089)
5. **Gateway Service** (Port 8080) - Start last

### Quick Start
Run the provided startup script:
```bash
start-services.bat
```

## Common Issues & Solutions

### Service Registration Issues
- **Symptom**: Services not appearing in Eureka dashboard
- **Solution**: Ensure Discovery Service starts first and wait 30 seconds before starting other services

### Database Connection Issues
- **Symptom**: Services fail to start with database errors
- **Solution**: 
  - Verify PostgreSQL is running
  - Check database credentials in application.properties
  - Ensure database 'testcase' exists

### JWT Authentication Issues
- **Symptom**: 401 Unauthorized errors
- **Solution**: 
  - Ensure JWT secret is consistent across all services
  - Verify JWT token is included in Authorization header
  - Check token expiry (30 minutes default)

### Gateway Routing Issues
- **Symptom**: 404 errors when accessing APIs through gateway
- **Solution**: 
  - Verify all services are registered with Eureka
  - Check gateway routing configuration
  - Ensure services are healthy in Eureka dashboard

### File Upload/Download Issues
- **Symptom**: File operations fail
- **Solution**: 
  - Verify file paths exist: `C:\Users\MANISH\Videos\Valorant\1\`, `2\`, `3\`
  - Check file permissions
  - Ensure directories are created

## Health Check URLs
- Gateway Health: http://localhost:8080/actuator/health
- Profile Health: http://localhost:8088/actuator/health
- Buyer Health: http://localhost:8089/actuator/health
- Seller Health: http://localhost:8081/actuator/health
- Eureka Dashboard: http://localhost:8761

## API Testing
Use the gateway as entry point: http://localhost:8080
- Profile APIs: `/home/**` and `/profile/**`
- Buyer APIs: `/v1/**`
- Seller APIs: `/v2/**`

## Security Notes
- Change default JWT secret in production
- Update database credentials
- Remove hardcoded Razorpay keys
- Update email credentials
- Use environment variables for sensitive data