# Backend Standard — Laravel API Template

A clean, reusable Laravel 13 API backend template with complete authentication system, profile management, and email verification via OTP.

## Features

- **Authentication** — Register, Login, Logout, Token Refresh, Token Verification
- **Email Verification** — OTP-based email verification before registration
- **Password Reset** — Forgot password flow with OTP verification
- **Profile Management** — View, Update, Delete profile with photo uploads
- **Location** — Update user latitude/longitude/city/country
- **User Lookup** — View any user by ID
- **API Tokens** — Laravel Sanctum with custom refresh token rotation

## Tech Stack

- **PHP** ^8.3
- **Laravel** ^13.0
- **Laravel Sanctum** ^4.3 (API token authentication)
- **Resend** (email delivery — optional, defaults to log driver)
- **SQLite** (default, easily switchable to MySQL/PostgreSQL)

## Quick Start

```bash
# 1. Clone the project
git clone <repo-url> my-project
cd my-project

# 2. Install dependencies
composer install

# 3. Setup environment
cp .env.example .env
php artisan key:generate

# 4. Run migrations
php artisan migrate --seed

# 5. Start the server
php artisan serve
```

The API will be available at `http://localhost:8000/api`.

## API Endpoints

### Public (No Auth Required)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/send-verification-code` | Send OTP to email |
| POST | `/api/auth/verify-email` | Verify OTP code |
| POST | `/api/auth/register` | Register new user |
| POST | `/api/auth/login` | Login (email or phone) |
| POST | `/api/auth/refresh` | Refresh access token |
| GET/POST | `/api/auth/verify-token` | Check token validity |
| POST | `/api/auth/forgot-password` | Send password reset OTP |
| POST | `/api/auth/verify-reset-code` | Verify reset OTP |
| POST | `/api/auth/reset-password` | Reset password |

### Protected (Bearer Token Required)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/logout` | Logout |
| GET | `/api/auth/me` | Get current user |
| POST | `/api/auth/password` | Change password |
| GET | `/api/profile` | Get profile |
| PUT/POST | `/api/profile` | Update profile |
| PUT/POST | `/api/profile/location` | Update location |
| DELETE | `/api/profile` | Delete account |
| GET | `/api/users/{id}` | Get user by ID |

## Project Structure

```
app/
├── Http/
│   ├── Controllers/Api/    # AuthController, ProfileController, UserController
│   ├── Requests/           # Form validation (Auth/, Profile/)
│   └── Resources/          # API Resources (UserResource)
├── Mail/                   # Email templates (OTP mails)
├── Models/                 # User, RefreshToken, OTP models
├── Providers/              # Service providers
└── Services/               # Business logic (Auth, Email, Password)
```

## Customization

This template is designed to be extended. To add new features:

1. Create a new **Model** in `app/Models/`
2. Create a **Migration** in `database/migrations/`
3. Create a **Controller** in `app/Http/Controllers/Api/`
4. Add **Form Requests** in `app/Http/Requests/`
5. Add **Routes** in `routes/api.php`
6. Optionally add a **Service** in `app/Services/`

## License

MIT
