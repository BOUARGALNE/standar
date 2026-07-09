<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class UserController extends Controller
{
    /**
     * Get a user by ID.
     */
    public function show($id): JsonResponse
    {
        $user = User::with(['familySituation', 'educationLevel', 'interests.category'])->find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found.',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json([
            'success' => true,
            'data'    => [
                'user' => new UserResource($user)
            ],
        ], Response::HTTP_OK);
    }
}
