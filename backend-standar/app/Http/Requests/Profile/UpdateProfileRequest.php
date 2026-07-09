<?php

namespace App\Http\Requests\Profile;

use Illuminate\Foundation\Http\FormRequest;

class UpdateProfileRequest extends FormRequest
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
            'name'         => ['sometimes', 'string', 'max:100'],
            'phone_number' => ['sometimes', 'string', 'max:20', 'unique:users,phone_number,' . $this->user()->id],
            'email'        => ['sometimes', 'string', 'email', 'max:255', 'unique:users,email,' . $this->user()->id],
            'birthday'     => ['sometimes', 'date', 'before:-18 years'],
            'city'         => ['sometimes', 'string', 'max:100'],
            'country'      => ['sometimes', 'string', 'max:100'],
            'photos'       => ['nullable', 'array', 'max:5'],
            'photos.*'     => ['image', 'mimes:jpeg,png,jpg,webp', 'max:5120'],
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
            'birthday'     => 'date of birth',
            'city'         => 'city',
            'country'      => 'country',
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
            'birthday.before' => 'You must be at least 18 years old.',
        ];
    }
}
