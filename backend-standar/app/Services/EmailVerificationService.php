<?php

namespace App\Services;

use App\Mail\EmailVerificationOtpMail;
use App\Models\EmailVerificationOtp;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class EmailVerificationService
{
    /**
     * OTP validity duration in minutes.
     */
    private const OTP_EXPIRY_MINUTES = 10;

    /**
     * Verification token validity duration in minutes (time to complete registration).
     */
    private const TOKEN_EXPIRY_MINUTES = 30;

    /**
     * Maximum OTP send attempts per email per hour (rate limiting).
     */
    private const MAX_ATTEMPTS_PER_HOUR = 5;

    /**
     * Send a verification OTP code to the given email.
     *
     * @param  string  $email
     * @return void
     *
     * @throws ValidationException
     */
    public function sendVerificationCode(string $email): void
    {
        // Ensure the email is not already registered
        if (User::where('email', $email)->exists()) {
            throw ValidationException::withMessages([
                'email' => ['This email address is already registered.'],
            ]);
        }

        // Rate limiting: max attempts per hour
        $recentAttempts = EmailVerificationOtp::where('email', $email)
            ->where('created_at', '>=', now()->subHour())
            ->count();

        if ($recentAttempts >= self::MAX_ATTEMPTS_PER_HOUR) {
            throw ValidationException::withMessages([
                'email' => ['Too many verification attempts. Please try again later.'],
            ]);
        }

        // Invalidate all previous codes for this email
        EmailVerificationOtp::where('email', $email)->delete();

        // Generate a 6-digit code
        $code = str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        // Store the OTP
        EmailVerificationOtp::create([
            'email'      => $email,
            'code'       => Hash::make($code),
            'expires_at' => now()->addMinutes(self::OTP_EXPIRY_MINUTES),
        ]);

        // Send the email
        Mail::to($email)->send(new EmailVerificationOtpMail(
            code: $code,
        ));
    }

    /**
     * Verify the OTP code and return a one-time verification token.
     *
     * @param  string  $email
     * @param  string  $code
     * @return string  The verification token
     *
     * @throws ValidationException
     */
    public function verifyCode(string $email, string $code): string
    {
        $otp = EmailVerificationOtp::where('email', $email)
            ->where('verified', false)
            ->latest('created_at')
            ->first();

        if (!$otp) {
            throw ValidationException::withMessages([
                'code' => ['No pending verification code found. Please request a new one.'],
            ]);
        }

        if ($otp->isExpired()) {
            $otp->delete();
            throw ValidationException::withMessages([
                'code' => ['The verification code has expired. Please request a new one.'],
            ]);
        }

        if (!Hash::check($code, $otp->code)) {
            throw ValidationException::withMessages([
                'code' => ['The verification code is invalid.'],
            ]);
        }

        // Mark as verified and generate a one-time verification token
        $verificationToken = Str::random(64);

        $otp->update([
            'verified'           => true,
            'verification_token' => hash('sha256', $verificationToken),
            // Extend expiry for the registration step
            'expires_at'         => now()->addMinutes(self::TOKEN_EXPIRY_MINUTES),
        ]);

        return $verificationToken;
    }

    /**
     * Validate a verification token during registration.
     *
     * @param  string  $email
     * @param  string  $verificationToken
     * @return void
     *
     * @throws ValidationException
     */
    public function validateVerificationToken(string $email, string $verificationToken): void
    {
        $otp = EmailVerificationOtp::where('email', $email)
            ->where('verified', true)
            ->where('verification_token', hash('sha256', $verificationToken))
            ->first();

        if (!$otp) {
            throw ValidationException::withMessages([
                'verification_token' => ['Invalid or expired verification token.'],
            ]);
        }

        if ($otp->isExpired()) {
            $otp->delete();
            throw ValidationException::withMessages([
                'verification_token' => ['The verification token has expired. Please verify your email again.'],
            ]);
        }

        // Clean up — one-time use
        $otp->delete();
    }
}
