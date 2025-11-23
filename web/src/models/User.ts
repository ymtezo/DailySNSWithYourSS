/**
 * User.ts
 * DailySNSWithYourSS Web版
 * 
 * ユーザーとアルバムのデータモデル
 */

import { Post } from './Post';

export interface User {
  id: string;
  username: string;
  displayName: string;
  profileImageURL?: string;
  followingIds: string[];
  followerIds: string[];
  createdAt: Date;
}

export interface Album {
  id: string;
  userId: string;
  userName: string;
  userProfileImageURL?: string;
  posts: Post[];
  createdAt: Date;
  updatedAt: Date;
}

/**
 * Userを作成
 */
export function createUser(
  username: string,
  displayName: string,
  id?: string,
  profileImageURL?: string,
  followingIds: string[] = [],
  followerIds: string[] = [],
  createdAt?: Date
): User {
  return {
    id: id || crypto.randomUUID(),
    username,
    displayName,
    profileImageURL,
    followingIds,
    followerIds,
    createdAt: createdAt || new Date()
  };
}

/**
 * Albumを作成
 */
export function createAlbum(
  userId: string,
  userName: string,
  posts: Post[] = [],
  id?: string,
  userProfileImageURL?: string,
  createdAt?: Date,
  updatedAt?: Date
): Album {
  const now = new Date();
  return {
    id: id || crypto.randomUUID(),
    userId,
    userName,
    userProfileImageURL,
    posts,
    createdAt: createdAt || now,
    updatedAt: updatedAt || now
  };
}
