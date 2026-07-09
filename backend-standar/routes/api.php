<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned the "api" middleware group.
|
*/

// ── Public routes (no authentication required) ────────────────────────────────
Route::prefix('auth')->name('auth.')->group(function () {
    Route::post('/send-verification-code', [AuthController::class, 'sendVerificationCode'])->name('send_verification_code');
    Route::post('/verify-email',           [AuthController::class, 'verifyEmail'])->name('verify_email');
    Route::post('/register', [AuthController::class, 'register'])->name('register');
    Route::post('/login',    [AuthController::class, 'login'])->name('login');
    Route::post('/refresh',  [AuthController::class, 'refresh'])->name('refresh');
    Route::match(['get', 'post'], '/verify-token', [AuthController::class, 'verifyToken'])->name('verify_token');

    // Password reset (forgot password flow)
    Route::post('/forgot-password',    [AuthController::class, 'forgotPassword'])->name('forgot_password');
    Route::post('/verify-reset-code',  [AuthController::class, 'verifyResetCode'])->name('verify_reset_code');
    Route::post('/reset-password',     [AuthController::class, 'resetPassword'])->name('reset_password');
});

// ── Protected routes (Sanctum token required) ─────────────────────────────────
Route::middleware('auth:sanctum')->prefix('auth')->name('auth.')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
    Route::get('/me',      [AuthController::class, 'me'])->name('me');
    Route::post('/password', [AuthController::class, 'changePassword'])->name('password.change');
});

Route::middleware('auth:sanctum')->group(function () {
    // Profile
    Route::get('/profile',    [ProfileController::class, 'show'])->name('profile.show');
    Route::match(['put', 'patch', 'post'], '/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::match(['put', 'patch', 'post'], '/profile/location', [ProfileController::class, 'updateLocation'])->name('profile.update_location');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Users
    Route::get('/users/{id}', [UserController::class, 'show'])->name('users.show');
});
