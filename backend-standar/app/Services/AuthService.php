<?php

namespace App\Services;

use App\Models\User;
use App\Models\RefreshToken;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class AuthService
{
    /**
     * Register a new user and return tokens.
     *
     * @param  array<string, mixed>  $data
     * @return array{user: User, token: string, refresh_token: string}
     *
     * @throws \Throwable
     */
    public function register(array $data): array
    {
        return DB::transaction(function () use ($data) {
            /** @var User $user */
            $user = User::create([
                'name'              => $data['name'],
                'phone_number'      => $data['phone_number'],
                'email'             => $data['email'],
                'password'          => $data['password'],   // hashed automatically via cast
                'birthday'          => $data['birthday'],
                'city'              => $data['city'],
                'country'           => $data['country'],
                'latitude'          => $data['latitude'] ?? null,
                'longitude'         => $data['longitude'] ?? null,
                'email_verified_at' => now(),
            ]);

            // Handle photo uploads
            if (isset($data['photos']) && is_array($data['photos'])) {
                $photoPaths = [];
                foreach ($data['photos'] as $photo) {
                    $path = $photo->store('users/photos', 'public');
                    $photoPaths[] = $path;
                }
                $user->update(['photos' => $photoPaths]);
            }

            return $this->createTokens($user);
        });
    }

    /**
     * Authenticate a user by email or phone number and return tokens.
     *
     * @param  string  $login     Email or phone number
     * @param  string  $password
     * @return array{user: User, token: string, refresh_token: string}
     *
     * @throws AuthenticationException
     */
    public function login(string $login, string $password): array
    {
        // Try to find user by email or phone number
        $user = User::where('email', $login)
            ->orWhere('phone_number', $login)
            ->first();

        if (!$user || !Hash::check($password, $user->password)) {
            throw new AuthenticationException('Invalid credentials.');
        }

        // Revoke previous tokens to keep only one active session
        $user->tokens()->delete();
        $user->refreshTokens()->update(['revoked_at' => now()]);

        return $this->createTokens($user);
    }

    /**
     * Refresh the access token using a valid refresh token.
     *
     * @param  string  $tokenString
     * @return array{user: User, token: string, refresh_token: string}
     *
     * @throws AuthenticationException
     */
    public function refresh(string $tokenString): array
    {
        $refreshToken = RefreshToken::where('token', $tokenString)->first();

        if (!$refreshToken || !$refreshToken->isValid()) {
            throw new AuthenticationException('Invalid or expired refresh token.');
        }

        $user = $refreshToken->user;

        // Revoke the old refresh token (rotation) and current access tokens
        $refreshToken->revoke();
        $user->tokens()->delete();

        return $this->createTokens($user);
    }

    /**
     * Revoke the current user's tokens (logout).
     *
     * @param  User  $user
     * @return void
     */
    public function logout(User $user): void
    {
        // Revoke all Sanctum access tokens
        $user->tokens()->delete();

        // Revoke all refresh tokens
        $user->refreshTokens()->update(['revoked_at' => now()]);
    }

    /**
     * Create a new access token and refresh token for the user.
     *
     * @param  User  $user
     * @return array{user: User, token: string, refresh_token: string}
     */
    private function createTokens(User $user): array
    {
        $accessToken = $user->createToken('api-token')->plainTextToken;
        
        $refreshToken = $user->refreshTokens()->create([
            'token'      => hash('sha256', Str::random(40)),
            'expires_at' => now()->addDays(30), // Refresh token is valid for 30 days
        ]);

        return [
            'user'          => $user,
            'token'         => $accessToken,
            'refresh_token' => $refreshToken->token,
        ];
    }
}
