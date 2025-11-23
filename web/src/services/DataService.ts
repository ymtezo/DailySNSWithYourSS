/**
 * DataService.ts
 * DailySNSWithYourSS Web版
 * 
 * データサービス（モック実装）
 */

import { Post, createPost, createPostItem, PostItemType } from '../models/Post';
import { User, Album, createUser, createAlbum } from '../models/User';

export interface DataServiceProtocol {
  fetchAlbums(): Promise<Album[]>;
  fetchRandomFollowingPosts(userId: string): Promise<Post[]>;
  fetchRandomGlobalPosts(): Promise<Post[]>;
  createPost(post: Post): Promise<Post>;
  fetchUser(id: string): Promise<User>;
}

export class DataService implements DataServiceProtocol {
  /**
   * アルバムを取得（モック）
   */
  async fetchAlbums(): Promise<Album[]> {
    await this.delay(500);
    return this.mockAlbums();
  }

  /**
   * フォロー中のユーザーの投稿を取得（モック）
   */
  async fetchRandomFollowingPosts(userId: string): Promise<Post[]> {
    await this.delay(500);
    const allPosts = this.mockPosts();
    return allPosts.slice(0, Math.min(5, allPosts.length));
  }

  /**
   * グローバル投稿を取得（モック）
   */
  async fetchRandomGlobalPosts(): Promise<Post[]> {
    await this.delay(500);
    return this.mockPosts();
  }

  /**
   * 投稿を作成（モック）
   */
  async createPost(post: Post): Promise<Post> {
    await this.delay(500);
    return post;
  }

  /**
   * ユーザーを取得（モック）
   */
  async fetchUser(id: string): Promise<User> {
    await this.delay(500);
    const users = this.mockUsers();
    return users.find(u => u.id === id) || createUser('unknown', 'Unknown User');
  }

  // モックデータ生成

  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  private mockUsers(): User[] {
    return [
      createUser('user1', 'Alice', '1'),
      createUser('user2', 'Bob', '2'),
      createUser('user3', 'Charlie', '3')
    ];
  }

  private mockPosts(): Post[] {
    const users = this.mockUsers();
    const posts: Post[] = [];

    users.forEach(user => {
      for (let i = 0; i < 3; i++) {
        const items = [
          createPostItem(PostItemType.Screenshot, `screenshot_${i}.jpg`),
          createPostItem(PostItemType.Comment, `This is a comment ${i}`)
        ];
        posts.push(createPost(user.id, items));
      }
    });

    return posts;
  }

  private mockAlbums(): Album[] {
    const users = this.mockUsers();
    return users.map(user => {
      const userPosts = this.mockPosts().filter(p => p.userId === user.id);
      return createAlbum(
        user.id,
        user.displayName,
        userPosts,
        undefined,
        user.profileImageURL
      );
    });
  }
}
