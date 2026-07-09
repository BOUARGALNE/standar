<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RefreshToken extends Model
{
    protected $fillable = [
        'user_id',
        'token',
        'expires_at',
        'revoked_at',
    ];

    protected $casts = [
        'expires_at' => 'datetime',
        'revoked_at' => 'datetime',
    ];

    // ------- Relations -------

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    // ------- Helpers -------

    /**
     * Check if the refresh token is still valid (not expired and not revoked).
     */
    public function isValid(): bool
    {
        return is_null($this->revoked_at) && $this->expires_at->isFuture();
    }

    /**
     * Revoke this refresh token.
     */
    public function revoke(): void
    {
        $this->update(['revoked_at' => now()]);
    }

    // ------- Scopes -------

    public function scopeValid($query)
    {
        return $query->whereNull('revoked_at')->where('expires_at', '>', now());
    }
}
