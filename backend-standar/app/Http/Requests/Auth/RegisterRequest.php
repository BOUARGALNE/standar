<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name'               => ['required', 'string', 'max:100'],
            'phone_number'       => ['required', 'string', 'max:20', 'unique:users,phone_number'],
            'email'              => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'password'           => ['required', 'string', 'min:6', 'confirmed'],
            'birthday'           => ['required', 'date', 'before:-18 years'],
            'city'               => ['required', 'string', 'max:100'],
            'country'            => ['required', 'string', 'max:100'],
            'latitude'           => ['nullable', 'numeric', 'between:-90,90'],
            'longitude'          => ['nullable', 'numeric', 'between:-180,180'],
            'photos'             => ['nullable', 'array', 'max:5'],
            'photos.*'           => ['image', 'mimes:jpeg,png,jpg,webp', 'max:5120'],
            'verification_token' => ['required', 'string'],
        ];
    }

    /**
     * Custom attribute names for error messages.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        return [
            'name'         => 'name',
            'phone_number' => 'phone number',
            'email'        => 'email address',
            'password'     => 'password',
            'birthday'     => 'date of birth',
            'city'         => 'city',
            'country'      => 'country',
            'latitude'     => 'latitude',
            'longitude'    => 'longitude',
            'photos'       => 'photos',
            'photos.*'     => 'photo',
        ];
    }

    /**
     * Custom error messages.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'birthday.before' => 'You must be at least 18 years old to register.',
        ];
    }
}
