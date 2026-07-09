<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EmailVerificationOtp extends Model
{
    /**
     * Only use created_at, not updated_at.
     */
    const UPDATED_AT = null;

    protected $fillable = [
        'email',
        'code',
        'verification_token',
        'verified',
        'expires_at',
    ];

    protected $casts = [
        'verified'   => 'boolean',
        'expires_at' => 'datetime',
        'created_at' => 'datetime',
    ];

    /**
     * Check if the OTP has expired.
     */
    public function isExpired(): bool
    {
        return $this->expires_at->isPast();
    }
}
