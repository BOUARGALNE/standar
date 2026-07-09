<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Storage;

class ProfileController extends Controller
{
    /**
     * Get the authenticated user's profile.
     */
    public function show(Request $request): JsonResponse
    {
        $user = $request->user();

        return response()->json([
            'success' => true,
            'message' => 'Profile retrieved successfully.',
            'data'    => [
                'user' => new UserResource($user)
            ],
        ], Response::HTTP_OK);
    }

    /**
     * Delete the authenticated user's account.
     */
    public function destroy(Request $request): JsonResponse
    {
        $user = $request->user();

        // Delete user's photos from storage if they exist
        if (!empty($user->photos)) {
            foreach ($user->photos as $photo) {
                if (Storage::disk('public')->exists($photo)) {
                    Storage::disk('public')->delete($photo);
                }
            }
        }

        // Delete the user
        $user->delete();

        // Revoke all tokens for the user
        $user->tokens()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Account deleted successfully.',
        ], Response::HTTP_OK);
    }

    /**
     * Update the authenticated user's profile.
     */
    public function update(\App\Http\Requests\Profile\UpdateProfileRequest $request): JsonResponse
    {
        $user = $request->user();
        $data = $request->validated();

        \Illuminate\Support\Facades\DB::beginTransaction();

        try {
            // Update simple fields
            $fillableData = collect($data)->except(['photos'])->toArray();
            if (!empty($fillableData)) {
                $user->update($fillableData);
            }

            // Handle photo uploads
            if (isset($data['photos']) && is_array($data['photos'])) {
                // Delete old photos
                if (!empty($user->photos)) {
                    foreach ($user->photos as $photo) {
                        if (Storage::disk('public')->exists($photo)) {
                            Storage::disk('public')->delete($photo);
                        }
                    }
                }

                // Store new photos
                $photoPaths = [];
                foreach ($data['photos'] as $photo) {
                    $path = $photo->store('users/photos', 'public');
                    $photoPaths[] = $path;
                }
                $user->update(['photos' => $photoPaths]);
            }

            \Illuminate\Support\Facades\DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Profile updated successfully.',
                'data'    => [
                    'user' => new UserResource($user)
                ],
            ], Response::HTTP_OK);
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'An error occurred while updating the profile.',
                'error'   => $e->getMessage(),
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Update the authenticated user's location (latitude & longitude).
     */
    public function updateLocation(\App\Http\Requests\Profile\UpdateLocationRequest $request): JsonResponse
    {
        $user = $request->user();
        $data = $request->validated();

        $updateData = [
            'latitude'  => $data['latitude'],
            'longitude' => $data['longitude'],
        ];

        if (isset($data['city'])) {
            $updateData['city'] = $data['city'];
        }

        if (isset($data['country'])) {
            $updateData['country'] = $data['country'];
        }

        $user->update($updateData);

        return response()->json([
            'success' => true,
            'message' => 'Location updated successfully.',
        ], Response::HTTP_OK);
    }
}
