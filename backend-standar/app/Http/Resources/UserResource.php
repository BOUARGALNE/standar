<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'            => $this->id,
            'name'          => $this->name,
            'phone_number'  => $this->phone_number,
            'email'         => $this->email,
            'birthday'      => $this->birthday?->format('Y-m-d'),
            'city'          => $this->city,
            'country'       => $this->country,
            'latitude'      => $this->latitude ? (float) $this->latitude : null,
            'longitude'     => $this->longitude ? (float) $this->longitude : null,
            'photos'        => $this->photos ? array_map(fn($path) => asset('storage/' . $path), $this->photos) : [],
            'profile_photo' => !empty($this->photos) ? asset('storage/' . $this->photos[0]) : null,
            'is_active'     => $this->is_active,
            'created_at'    => $this->created_at?->toISOString(),
        ];
    }
}
