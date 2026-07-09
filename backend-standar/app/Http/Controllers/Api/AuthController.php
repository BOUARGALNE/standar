<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\ChangePasswordRequest;
use App\Http\Requests\Auth\ForgotPasswordRequest;
use App\Http\Requests\Auth\LoginRequest;
use App\Http\Requests\Auth\RegisterRequest;
use App\Http\Requests\Auth\RefreshTokenRequest;
use App\Http\Requests\Auth\ResetPasswordRequest;
use App\Http\Requests\Auth\SendVerificationCodeRequest;
use App\Http\Requests\Auth\VerifyEmailRequest;
use App\Http\Requests\Auth\VerifyResetCodeRequest;
use App\Http\Resources\UserResource;
use App\Services\AuthService;
use App\Services\EmailVerificationService;
use App\Services\PasswordResetService;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function __construct(
        private readonly AuthService $authService,
        private readonly PasswordResetService $passwordResetService,
        private readonly EmailVerificationService $emailVerificationService,
    ) {}

    /**
     * Send a verification OTP code to the given email (pre-registration).
     */
    public function sendVerificationCode(SendVerificationCodeRequest $request): JsonResponse
    {
        try {
            $this->emailVerificationService->sendVerificationCode($request->input('email'));

            return response()->json([
                'success' => true,
                'message' => 'A verification code has been sent to your email.',
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error.',
                'errors'  => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while sending the verification code.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Verify the email OTP code and return a verification token.
     */
    public function verifyEmail(VerifyEmailRequest $request): JsonResponse
    {
        try {
            $verificationToken = $this->emailVerificationService->verifyCode(
                $request->input('email'),
                $request->input('code'),
            );

            return response()->json([
                'success' => true,
                'message' => 'Email verified successfully.',
                'data'    => [
                    'verification_token' => $verificationToken,
                ],
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Verification failed.',
                'errors'  => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred during email verification.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Register a new user.
     */
    public function register(RegisterRequest $request): JsonResponse
    {
        try {
            // Validate the verification token before creating the user
            $this->emailVerificationService->validateVerificationToken(
                $request->input('email'),
                $request->input('verification_token'),
            );

            ['user' => $user, 'token' => $token, 'refresh_token' => $refreshToken] = $this->authService->register(
                $request->validated()
            );

            return response()->json([
                'success' => true,
                'message' => 'Account created successfully.',
                'data'    => [
                    'user_id'       => $user->id,
                    'profile_photo' => !empty($user->photos) ? asset('storage/' . $user->photos[0]) : null,
                    'token'         => $token,
                    'refresh_token' => $refreshToken,
                ],
            ], Response::HTTP_CREATED);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error.',
                'errors'  => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred during registration.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Authenticate an existing user.
     */
    public function login(LoginRequest $request): JsonResponse
    {
        try {
            ['user' => $user, 'token' => $token, 'refresh_token' => $refreshToken] = $this->authService->login(
                $request->input('login'),
                $request->input('password')
            );

            return response()->json([
                'success' => true,
                'message' => 'Login successful.',
                'data'    => [
                    'user_id'       => $user->id,
                    'profile_photo' => !empty($user->photos) ? asset('storage/' . $user->photos[0]) : null,
                    'token'         => $token,
                    'refresh_token' => $refreshToken,
                ],
            ], Response::HTTP_OK);
        } catch (AuthenticationException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], Response::HTTP_UNAUTHORIZED);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred during login.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Refresh the access token using a refresh token.
     */
    public function refresh(RefreshTokenRequest $request): JsonResponse
    {
        try {
            ['user' => $user, 'token' => $token, 'refresh_token' => $refreshToken] = $this->authService->refresh(
                $request->input('refresh_token')
            );

            return response()->json([
                'success' => true,
                'message' => 'Token refreshed successfully.',
                'data'    => [
                    'token'         => $token,
                    'refresh_token' => $refreshToken,
                ],
            ], Response::HTTP_OK);
        } catch (AuthenticationException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], Response::HTTP_UNAUTHORIZED);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while refreshing the token.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Logout the current authenticated user.
     */
    public function logout(Request $request): JsonResponse
    {
        $this->authService->logout($request->user());

        return response()->json([
            'success' => true,
            'message' => 'Logout successful.',
        ], Response::HTTP_OK);
    }

    /**
     * Return the currently authenticated user profile.
     */
    public function me(Request $request): JsonResponse
    {
        $user = $request->user();

        return response()->json([
            'success' => true,
            'data'    => ['user' => new UserResource($user)],
        ], Response::HTTP_OK);
    }

    /**
     * Change the authenticated user's password.
     */
    public function changePassword(ChangePasswordRequest $request): JsonResponse
    {
        $user = $request->user();
        
        $user->update([
            'password' => \Illuminate\Support\Facades\Hash::make($request->input('password')),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password changed successfully.',
        ], Response::HTTP_OK);
    }

    /**
     * Send a password reset OTP code to the user's email.
     */
    public function forgotPassword(ForgotPasswordRequest $request): JsonResponse
    {
        try {
            $this->passwordResetService->sendResetCode($request->input('email'));

            return response()->json([
                'success' => true,
                'message' => 'A verification code has been sent to your email.',
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error.',
                'errors'  => $e->errors(),
            ], Response::HTTP_TOO_MANY_REQUESTS);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while sending the reset code.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Verify the OTP code and return a reset token.
     */
    public function verifyResetCode(VerifyResetCodeRequest $request): JsonResponse
    {
        try {
            $resetToken = $this->passwordResetService->verifyResetCode(
                $request->input('email'),
                $request->input('code'),
            );

            return response()->json([
                'success' => true,
                'message' => 'Code verified successfully.',
                'data'    => [
                    'reset_token' => $resetToken,
                ],
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Verification failed.',
                'errors'  => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred during verification.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Reset the password using the reset token.
     */
    public function resetPassword(ResetPasswordRequest $request): JsonResponse
    {
        try {
            $this->passwordResetService->resetPassword(
                $request->input('email'),
                $request->input('reset_token'),
                $request->input('password'),
            );

            return response()->json([
                'success' => true,
                'message' => 'Password has been reset successfully. Please log in with your new password.',
            ], Response::HTTP_OK);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Password reset failed.',
                'errors'  => $e->errors(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while resetting the password.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Verify if the provided token is valid.
     */
    public function verifyToken(Request $request): JsonResponse
    {
        $tokenString = $request->input('token') ?? $request->bearerToken();

        if (!$tokenString) {
            return response()->json([
                'success' => false,
                'authenticated'   => false,
                'message' => 'Token is missing.',
            ], Response::HTTP_BAD_REQUEST);
        }

        $token = \Laravel\Sanctum\PersonalAccessToken::findToken($tokenString);

        if (!$token || !$token->tokenable) {
            return response()->json([
                'success' => true,
                'authenticated'   => false,
                'message' => 'Token is invalid or expired.',
            ], Response::HTTP_OK);
        }

        return response()->json([
            'success' => true,
            'authenticated'   => true,
            'message' => 'Token is valid.',
        ], Response::HTTP_OK);
    }
}
