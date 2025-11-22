@echo off
echo Starting Virtual BookStore Microservices...

echo.
echo Starting Discovery Service (Eureka Server)...
start "Discovery Service" cmd /k "cd /d C:\Users\MANISH\Projects\Discoveryclient && mvn spring-boot:run"

echo Waiting for Discovery Service to start...
timeout /t 30 /nobreak

echo.
echo Starting Profile Service...
start "Profile Service" cmd /k "cd /d C:\Users\MANISH\Projects\profile && mvn spring-boot:run"

echo.
echo Starting Seller Service...
start "Seller Service" cmd /k "cd /d C:\Users\MANISH\Projects\Seller-Service && mvn spring-boot:run"

echo.
echo Starting Buyer Service...
start "Buyer Service" cmd /k "cd /d C:\Users\MANISH\Projects\BuyerService && mvn spring-boot:run"

echo Waiting for services to register with Eureka...
timeout /t 20 /nobreak

echo.
echo Starting Gateway Service...
start "Gateway Service" cmd /k "cd /d C:\Users\MANISH\Projects\gateway && mvn spring-boot:run"

echo.
echo All services are starting up...
echo Gateway: http://localhost:8080
echo Eureka Dashboard: http://localhost:8761
echo Profile Service: http://localhost:8088
echo Buyer Service: http://localhost:8089
echo Seller Service: http://localhost:8081
echo.
echo Press any key to exit...
pause