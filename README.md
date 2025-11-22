# Virtual BookStore Microservices API Documentation

## Architecture Overview
This is a microservices-based virtual bookstore application with the following services:
- **Gateway Service** (Port 8080) - API Gateway
- **Profile Service** (Port 8088) - User authentication and profile management
- **BuyerService** (Port 8089) - Book purchasing and reading functionality
- **Seller-Service** (Port 8081) - Book publishing and management
- **Discovery Service** (Port 8761) - Eureka service registry

## Gateway Routes
All requests go through the API Gateway at `http://localhost:8080`

| Route Pattern | Target Service | Port | Description |
|---------------|----------------|------|-------------|
| `/home/**` | VirtualBookStore | 8088 | Profile and authentication |
| `/v1/**` | BuyerService | 8089 | Book purchasing APIs |
| `/v2/**` | Seller-Service | 8081 | Book management APIs |
| `/profile/**` | Profile Service | 8088 | User profile management |
| `/eureka/**` | Discovery Service | 8761 | Service registry dashboard |

---

## Profile Service APIs (`/user`)

### Authentication
- **POST** `/user/signup` - User registration
- **POST** `/user/login` - User login (returns JWT)
- **POST** `/user/verify` - JWT token verification

### User Management
- **GET** `/user/roleset` - Set user role (requires OTP)
- **GET** `/user/otp` - Generate OTP for operations
- **POST** `/user/resetpswrd` - Reset password with OTP

### Profile Picture
- **POST** `/user/ufp` - Upload profile picture
- **GET** `/user/dwfp` - Download profile picture
- **POST** `/user/dfp` - Delete profile picture

---

## BuyerService APIs (`/buyers`)

### User Inventory
- **GET** `/buyers/buyerrid` - Get buyer inventory ID
- **GET** `/buyers/bookinventory` - Get purchased books (paginated)
- **GET** `/buyers/Invchaps` - Get purchased chapters for a book

### Reviews
- **POST** `/buyers/postreview` - Write book review
- **GET** `/buyers/myreview` - Get user's review for a book
- **POST** `/buyers/updatereview` - Update existing review

### Reading & Purchasing
- **GET** `/buyers/readChapter` - Read purchased chapter content
- **POST** `/buyers/orderCreation` - Create purchase order
- **POST** `/buyers/verifypay` - Verify payment and complete purchase
- **GET** `/buyers/rzrpayID` - Get Razorpay order ID
- **GET** `/buyers/getordrs` - Get user's order history (paginated)

---

## Seller-Service APIs (`/home`)

### Seller Management
- **GET** `/home/sellerid` - Get seller inventory ID
- **GET** `/home/seecreds` - View seller credentials
- **PUT** `/home/setcreds` - Set seller payment credentials
- **GET** `/home/orderlist` - Get seller's orders (paginated)
- **GET** `/home/buyercount` - Get buyer count for seller

### Book Management
- **POST** `/home/savebook` - Create new book
- **GET** `/home/booksaffiliated` - Get seller's books (paginated)
- **GET** `/home/getbookbyid` - Get book details by ID
- **GET** `/home/booksearch` - Search books by name
- **DELETE** `/home/deletebook` - Delete book (owner only)

### Book Images
- **POST** `/home/setimage` - Upload book cover image
- **GET** `/home/getimage` - Get book cover image
- **GET** `/home/deleteimage` - Delete book cover image

### Authors
- **GET** `/home/getauthor` - Search authors by name
- **POST** `/home/createauthor` - Create new author
- **GET** `/home/author` - Get author details by ID
- **GET** `/home/authorbooks` - Get books by author (paginated)

### Publishers
- **GET** `/home/getpublisher` - Search publishers by name
- **POST** `/home/createpublisher` - Create new publisher
- **GET** `/home/publisher` - Get publisher details by ID
- **GET** `/home/publisherbooks` - Get books by publisher (paginated)

### Chapters
- **GET** `/home/getchapbybook` - Get chapters for a book
- **GET** `/home/getchapbyid` - Get chapter details by ID
- **GET** `/home/getbookbychap` - Get book ID from chapter ID
- **POST** `/home/createchapter` - Create new chapter
- **PUT** `/home/updatechapter` - Update chapter details
- **GET** `/home/deletechap` - Delete chapter
- **GET** `/home/readfile` - Read chapter file (owner only)
- **GET** `/home/setfiles` - Upload chapter content file

### Reviews & Ratings
- **GET** `/home/booksrating` - Get book reviews and ratings (paginated)
- **GET** `/home/getsellerbybook` - Get seller ID by book ID
- **GET** `/home/getbychap` - Get seller ID by chapter ID

---

## Common Request/Response Patterns

### Authentication
All protected endpoints require JWT token in Authorization header:
```
Authorization: Bearer <jwt_token>
```

### Pagination
Most list endpoints support pagination with `pageno` parameter:
```
GET /endpoint?pageno=1
```

### Error Responses
- `200/202` - Success
- `400` - Bad Request
- `401` - Unauthorized
- `409` - Conflict
- `417` - Expectation Failed

### File Upload
File upload endpoints accept `multipart/form-data`:
```
Content-Type: multipart/form-data
```

---

## Usage Examples

### Complete User Journey

1. **Register**: `POST /user/signup`
2. **Login**: `POST /user/login` → Get JWT
3. **Set Role**: `GET /user/otp` → `GET /user/roleset`
4. **Browse Books**: `GET /home/booksearch?name=book`
5. **Purchase**: `POST /buyers/orderCreation` → `POST /buyers/verifypay`
6. **Read**: `GET /buyers/readChapter?Chapid=1`
7. **Review**: `POST /buyers/postreview`

### Seller Journey

1. **Get Seller ID**: `GET /home/sellerid`
2. **Create Author**: `POST /home/createauthor`
3. **Create Book**: `POST /home/savebook`
4. **Add Chapters**: `POST /home/createchapter`
5. **Upload Content**: `GET /home/setfiles`
6. **Monitor Sales**: `GET /home/orderlist`

---

## Service Dependencies
- **Database**: PostgreSQL (localhost:5432)
- **Service Discovery**: Eureka Server (localhost:8761)
- **Payment**: Razorpay Integration
- **Tracing**: Zipkin (localhost:9411)
- **Email**: Yahoo SMTP

## Security Features
- JWT-based authentication
- Role-based access control
- OTP verification for sensitive operations
- Owner-only access for content management
- Password encryption with salt rounds