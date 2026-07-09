<?php

namespace App\Services;

use App\Mail\PasswordResetOtpMail;
use App\Models\PasswordResetOtp;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class PasswordResetService
{
    /**
     * OTP validity duration in minutes.
     */
    private const OTP_EXPIRY_MINUTES = 10;

    /**
     * Maximum OTP send attempts per email per hour (rate limiting).
     */
    private const MAX_ATTEMPTS_PER_HOUR = 5;

    /**
     * Send a password reset OTP code to the given email.
     *
     * @param  string  $email
     * @return void
     *
     * @throws ValidationException
     */
    public function sendResetCode(string $email): void
    {
        $user = User::where('email', $email)->firstOrFail();

        // Rate limiting: max attempts per hour
        $recentAttempts = PasswordResetOtp::where('email', $email)
            ->where('created_at', '>=', now()->subHour())
            ->count();

        if ($recentAttempts >= self::MAX_ATTEMPTS_PER_HOUR) {
            throw ValidationException::withMessages([
                'email' => ['Too many reset attempts. Please try again later.'],
            ]);
        }

        // Invalidate all previous codes for this email
        PasswordResetOtp::where('email', $email)->delete();

        // Generate a 6-digit code
        $code = str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        // Store the OTP
        PasswordResetOtp::create([
            'email'      => $email,
            'code'       => Hash::make($code),
            'expires_at' => now()->addMinutes(self::OTP_EXPIRY_MINUTES),
        ]);

        // Send the email
        Mail::to($email)->send(new PasswordResetOtpMail(
            code: $code,
            userName: $user->name,
        ));
    }

    /**
     * Verify the OTP code and return a one-time reset token.
     *
     * @param  string  $email
     * @param  string  $code
     * @return string  The reset token
     *
     * @throws ValidationException
     */
    public function verifyResetCode(string $email, string $code): string
    {
        $otp = PasswordResetOtp::where('email', $email)
            ->where('verified', false)
            ->latest('created_at')
            ->first();

        if (!$otp) {
            throw ValidationException::withMessages([
                'code' => ['No pending reset code found. Please request a new one.'],
            ]);
        }

        if ($otp->isExpired()) {
            $otp->delete();
            throw ValidationException::withMessages([
                'code' => ['The reset code has expired. Please request a new one.'],
            ]);
        }

        if (!Hash::check($code, $otp->code)) {
            throw ValidationException::withMessages([
                'code' => ['The reset code is invalid.'],
            ]);
        }

        // Mark as verified and generate a one-time reset token
        $resetToken = Str::random(64);

        $otp->update([
            'verified'    => true,
            'reset_token' => hash('sha256', $resetToken),
            // Extend expiry for the reset step (15 min window)
            'expires_at'  => now()->addMinutes(15),
        ]);

        return $resetToken;
    }

    /**
     * Reset the user's password using the reset token.
     *
     * @param  string  $email
     * @param  string  $resetToken
     * @param  string  $newPassword
     * @return void
     *
     * @throws ValidationException
     */
    public function resetPassword(string $email, string $resetToken, string $newPassword): void
    {
        $otp = PasswordResetOtp::where('email', $email)
            ->where('verified', true)
            ->where('reset_token', hash('sha256', $resetToken))
            ->first();

        if (!$otp) {
            throw ValidationException::withMessages([
                'reset_token' => ['Invalid or expired reset token.'],
            ]);
        }

        if ($otp->isExpired()) {
            $otp->delete();
            throw ValidationException::withMessages([
                'reset_token' => ['The reset token has expired. Please start the process again.'],
            ]);
        }

        // Update the user's password
        $user = User::where('email', $email)->firstOrFail();
        $user->update(['password' => Hash::make($newPassword)]);

        // Revoke all tokens (force re-login)
        $user->tokens()->delete();
        $user->refreshTokens()->update(['revoked_at' => now()]);

        // Clean up all OTPs for this email
        PasswordResetOtp::where('email', $email)->delete();
    }
}
